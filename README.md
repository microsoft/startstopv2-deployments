# Start/Stop VMs during off-hours overview (V2)

The Start/Stop VMs during off-hours feature starts or stops enabled Azure VMs. It starts or stops machines on user-defined schedules, provides insights through Azure Application Insights, and sends optional emails by using action groups. The feature can be enabled on both Azure Resource Manager and classic VMs for most scenarios.

V2 User Guide : https://docs.microsoft.com/azure/azure-functions/start-stop-vms/overview

**Note:** Before you deploy this solution into your Azure subscription, please make sure you have **_owner_** permission at the subscription level.

# Global Azure

<a href="https://portal.azure.com/#create/microsoftcorporation1620879115842.startstopv2startstopv2-08252021" target="_blank">
  <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true"/>
</a>

### Get Latest Version (Existing Users)
 
 Customers who have already deployed our Start/Stop V2 solution from the marketplace can use the below link to get the latest version. Please make sure you pass all the resource names correctly by referring to your existing deployment. This is a **one-time manual effort for existing users** to get the latest version, and from there you can configure the auto-update feature to get the latest version automatically.

[![Deploy to Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fstartstopv2prod.blob.core.windows.net%2Fartifacts%2Fssv2autoupdate.json)

<p>
  
# Fairfax/USGOV

<a href="https://portal.azure.us/#create/microsoftcorporation1620879115842.startstopv2-gov-fairfaxstartstopv2gov-09012021" target="_blank">
  <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true"/>
</a>

 ### Get Latest Version (Existing Users)
 
 Customers who have already deployed our Start/Stop V2 solution from the marketplace can use the below link to get the latest version. Please make sure you pass all the resource names correctly by referring to your existing deployment. This is a **one-time manual effort for existing users** to get the latest version, and from there you can configure the auto-update feature to get the latest version automatically.

 [![Deploy to Azure](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true)](https://portal.azure.us/?microsoft_azure_marketplace_itemhidekey=cuidCustomDeployment#create/Microsoft.Template/uri/https%3A%2F%2Fstartstopv2prod.blob.core.windows.net%2Fartifacts%2Fssv2autoupdateff.json)
  
<p>
  
# Enable Multi-Subscription Support
After the start/stop deployment is completed, please follow the steps below to enable the feature to take action across multiple subscriptions:
1. Copy the name of the Azure function that you had created during the deployment
1. Navigate to your secondary subscription -->  Select the subscription ---> Click on Access Control (IAM)
1. Click the button <b>"Add role assignments"</b>  
1. Select the "**_contributor_**" role from the dropdown
1. Enter the name of the Azure function in the "Select search by name or email address" box. Select the function name
1. Click the <b>Save</b> button

# Known issues
- The CostAnalyticsFunction and SavingsAnalyticsFunction functions might return failures such as 429 Too Many Requests errors. There is no ETA for fixing this issue, but this function does not impact the functionality of the Start/Stop V2 solution. This function is used by Microsoft to estimate aggregate savings of Start/Stop V2 across customers.

# Customer Support Contact
Please follow the steps below if you want to submit a support ticket from the Azure portal:
  
1. Go to https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview (if public cloud) or https://portal.azure.us/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview (if US Government cloud)
2. Click Create a support request
3. In the Summary field, provide a description of the issue
4. In the Issue type field, select Technical
5. Select the subscription that you deployed to
6. Select All services
7. Select Start-Stop V2
8. Select the appropriate topic from the list
9. Follow the remaining steps in the form to create the support ticket

**Note:** We will continue to support issues submitted on GitHub
  
# Microsoft Open Source Code of Conduct
https://opensource.microsoft.com/codeofconduct

# Contributing
This project welcomes contributions and suggestions. Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.


# Trademark
This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft trademarks or logos is subject to and must follow Microsoft's Trademark & Brand Guidelines. Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship. Any use of third-party trademarks or logos are subject to those third-party's policies.
