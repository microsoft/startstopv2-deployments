# Start/Stop VMs during off-hours overview (V2)

The Start/Stop VMs during off-hours feature start or stops enabled Azure VMs. It starts or stops machines on user-defined schedules, provides insights through Azure Application Insights, and sends optional emails by using action groups. The feature can be enabled on both Azure Resource Manager and classic VMs for most scenarios.

V2 User Guide : https://docs.microsoft.com/en-us/azure/azure-functions/start-stop-vms/overview

**Note:** Before you deploy this solution into your azure subscription, please make sure you have **_owner_** permission at the subscription level.

# Global Azure (Preview) 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fstartstopv2prod.blob.core.windows.net%2Fartifacts%2Fazuredeploy.json%3Fsv%3D2019-02-02%26st%3D2020-06-24T00%253A29%253A01Z%26se%3D2030-06-25T00%253A29%253A00Z%26sr%3Dc%26sp%3Dr%26sig%3Db8ZTNoY46IANeOadIpzSfEXaBcwymkEhF8v3ICnKhps%253D" target="_blank">
  <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true"/>
</a>
<p>
  
# Fairfax/USGOV (Preview)

<a href="https://portal.azure.us/?microsoft_azure_marketplace_itemhidekey=cuidCustomDeployment#create/Microsoft.Template/uri/https%3A%2F%2Fstartstopv2prod.blob.core.windows.net%2Fartifacts%2Fazuredeployff.json%3Fsv%3D2019-02-02%26st%3D2020-06-24T00%253A29%253A01Z%26se%3D2030-06-25T00%253A29%253A00Z%26sr%3Dc%26sp%3Dr%26sig%3Db8ZTNoY46IANeOadIpzSfEXaBcwymkEhF8v3ICnKhps%253D" target="_blank">
  <img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazure.svg?sanitize=true"/>
</a>

<p>
  
# Enable Multi-Subscription support
After the start/stop deployment completes, please follow the below steps to enable the start/stop to take action across multiple subscriptions
1. Copy the name of the Azure function that you had created during the deployment
1. Navigate to your secondary subscription -->  Select the subscription ---> Click on Access Control (IAM)
1. Click the button <b>"Add role assignments"</b>  
1. Select the "_contributor_" role from the dropdown
1. Enter the name of the Azure function in the "Select search by name or email address" box. Select the function name
1. Click the <b>Save</b> button

# Microsoft Open Source Code of Conduct
https://opensource.microsoft.com/codeofconduct

# Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.


# Trademark
Trademarks This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft trademarks or logos is subject to and must follow Microsoft's Trademark & Brand Guidelines. Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship. Any use of third-party trademarks or logos are subject to those third-party's policies.
