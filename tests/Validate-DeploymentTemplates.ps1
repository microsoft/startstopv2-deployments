$ErrorActionPreference = 'Stop'

function Assert-Condition {
    param(
        [Parameter(Mandatory)]
        [bool] $Condition,

        [Parameter(Mandatory)]
        [string] $Message
    )

    if (-not $Condition) {
        throw $Message
    }
}

$repositoryRoot = Split-Path -Parent $PSScriptRoot
$artifactRoot = Join-Path $repositoryRoot 'artifacts'
$templatePaths = @(
    (Join-Path $artifactRoot 'nestedtemplates\AutomationUpdate.json'),
    (Join-Path $artifactRoot 'nestedtemplates\AutomationUpdateff.json')
)
$expectedConfigurationSettings = @(
    'AzureClientOptions__ApplicationInsightName',
    'AzureClientOptions__ApplicationInsightRegion',
    'AzureClientOptions__AutoUpdateRegionsUri',
    'AzureClientOptions__AutoUpdateTemplateUri',
    'AzureClientOptions__AzureEnvironment',
    'AzureClientOptions__AzEnabled',
    'AzureClientOptions__EnableAutoUpdate',
    'AzureClientOptions__FunctionAppName',
    'AzureClientOptions__ResourceGroup',
    'AzureClientOptions__ResourceGroupRegion',
    'AzureClientOptions__StorageAccountName',
    'AzureClientOptions__SubscriptionId',
    'AzureClientOptions__TenantId',
    'AzureClientOptions__Version',
    'AzureClientOptions__WorkSpaceName',
    'AzureClientOptions__WorkSpaceRegion',
    'CentralizedLoggingOptions__InstrumentationKey',
    'CentralizedLoggingOptions__Version',
    'StorageOptions__AutoUpdateRequestDetailsStoreTable',
    'StorageOptions__AutoUpdateRequestQueue',
    'StorageOptions__CreateAutoStopAlertRequestQueue',
    'StorageOptions__ExecutionRequestQueue',
    'StorageOptions__OrchestrationRequestQueue',
    'StorageOptions__RequestStoreTable',
    'StorageOptions__SavingsRequestQueue',
    'StorageOptions__StorageAccountConnectionString',
    'StorageOptions__SubscriptionRequestStoreTable'
)

Get-ChildItem -Path $artifactRoot -Filter '*.json' -Recurse | ForEach-Object {
    try {
        Get-Content -Path $_.FullName -Raw | ConvertFrom-Json -Depth 100 | Out-Null
    }
    catch {
        throw "Invalid JSON in $($_.FullName): $($_.Exception.Message)"
    }
}

foreach ($templatePath in $templatePaths) {
    $template = Get-Content -Path $templatePath -Raw | ConvertFrom-Json -Depth 100
    $functionApp = @($template.resources | Where-Object type -eq 'Microsoft.Web/sites')
    Assert-Condition ($functionApp.Count -eq 1) "$templatePath must contain exactly one Function App resource."

    $configurationSettings = @(
        $functionApp[0].properties.siteConfig.appSettings |
            Where-Object name -Match '^(AzureClientOptions|StorageOptions|CentralizedLoggingOptions)(:|__)'
    )
    Assert-Condition (
        (Compare-Object $expectedConfigurationSettings @($configurationSettings.name)).Count -eq 0
    ) "$templatePath does not contain the expected .NET configuration settings."
    Assert-Condition (
        @($configurationSettings | Where-Object name -Like '*:*').Count -eq 0
    ) "$templatePath contains colon-separated Function App settings."
    Assert-Condition (
        @($configurationSettings | Where-Object name -NotLike '*__*').Count -eq 0
    ) "$templatePath contains a .NET configuration setting without a double-underscore separator."

    $roleDefinitionDeployment = @(
        $template.resources |
            Where-Object type -eq 'Microsoft.Resources/deployments'
    )
    Assert-Condition ($roleDefinitionDeployment.Count -eq 1) "$templatePath must contain one host-key role definition deployment."
    Assert-Condition (
        $roleDefinitionDeployment[0].name -eq "[variables('functionHostKeyReaderRoleDefinitionDeploymentName')]"
    ) "$templatePath must use the deterministic resource-group-specific role definition deployment name."
    Assert-Condition (
        $roleDefinitionDeployment[0].subscriptionId -eq '[subscription().subscriptionId]'
    ) "$templatePath must deploy the custom role definition to the current subscription."
    Assert-Condition (
        $roleDefinitionDeployment[0].properties.parameters.assignableScope.value -eq '[resourceGroup().id]'
    ) "$templatePath must limit the custom role's assignable scope to the deployment resource group."

    $roleDefinition = @(
        $roleDefinitionDeployment[0].properties.template.resources |
            Where-Object type -eq 'Microsoft.Authorization/roleDefinitions'
    )
    Assert-Condition ($roleDefinition.Count -eq 1) "$templatePath must contain one custom role definition."
    Assert-Condition (
        $roleDefinition[0].apiVersion -eq '2022-04-01'
    ) "$templatePath must use the stable custom role definition API."

    $roleActions = @($roleDefinition[0].properties.permissions[0].actions)
    Assert-Condition (
        $roleActions.Count -eq 1 -and
        $roleActions[0] -eq 'Microsoft.Web/sites/host/listkeys/action'
    ) "$templatePath custom role must grant only Microsoft.Web/sites/host/listkeys/action."

    $roleAssignment = @(
        $template.resources |
            Where-Object type -eq 'Microsoft.Authorization/roleAssignments'
    )
    Assert-Condition ($roleAssignment.Count -eq 1) "$templatePath must contain one host-key role assignment."
    Assert-Condition (
        $roleAssignment[0].apiVersion -eq '2022-04-01'
    ) "$templatePath must use the stable role assignment API."
    Assert-Condition (
        $roleAssignment[0].scope -eq "[concat('Microsoft.Web/sites/', variables('functionAppNameStartStopV2'))]"
    ) "$templatePath role assignment must be scoped to the Function App."
    Assert-Condition (
        @($roleAssignment[0].dependsOn) -contains "[variables('functionHostKeyReaderRoleDefinitionDeploymentName')]"
    ) "$templatePath role assignment must depend on the custom role definition deployment."
    Assert-Condition (
        $roleAssignment[0].properties.principalType -eq 'ServicePrincipal'
    ) "$templatePath role assignment must identify the managed identity as a service principal."
    Assert-Condition (
        $roleAssignment[0].properties.principalId -eq "[reference(resourceId('Microsoft.Web/sites', variables('functionAppNameStartStopV2')), '2022-03-01', 'Full').identity.principalId]"
    ) "$templatePath role assignment must target the Function App system-assigned managed identity."
    Assert-Condition (
        $template.variables.functionHostKeyReaderRoleDefinitionId -Like '[[]guid(*'
    ) "$templatePath role definition ID must be deterministic."
    Assert-Condition (
        $template.variables.functionHostKeyReaderRoleAssignmentId -Like '[[]guid(*'
    ) "$templatePath role assignment ID must be deterministic."
    Assert-Condition (
        $template.variables.functionHostKeyReaderRoleDefinitionDeploymentName -Like '[[]concat(*uniqueString(resourceGroup().id)*'
    ) "$templatePath role definition deployment name must be deterministic per resource group."
}

$readme = Get-Content -Path (Join-Path $repositoryRoot 'README.md') -Raw
foreach ($requiredTerm in @(
    'AllowSharedKeyAccess',
    'AzureWebJobsStorage',
    'WEBSITE_CONTENTAZUREFILECONNECTIONSTRING',
    'StorageOptions__StorageAccountConnectionString'
)) {
    Assert-Condition ($readme.Contains($requiredTerm)) "README.md must document the shared-key requirement and $requiredTerm."
}

Write-Output 'Deployment template validation passed.'
