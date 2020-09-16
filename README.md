# Start/Stop VMs during off-hours overview

The Start/Stop VMs during off-hours feature start or stops enabled Azure VMs. It starts or stops machines on user-defined schedules, provides insights through Azure Monitor logs, and sends optional emails by using action groups. The feature can be enabled on both Azure Resource Manager and classic VMs for most scenarios.

Visit https://docs.microsoft.com/en-us/azure/automation/automation-solution-vm-management


# Prod - Public 

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fstartstopv2prod.blob.core.windows.net%2Fartifacts%2Fazuredeploy.json%3Fsv%3D2019-02-02%26st%3D2020-06-24T00%253A29%253A01Z%26se%3D2030-06-25T00%253A29%253A00Z%26sr%3Dc%26sp%3Dr%26sig%3Db8ZTNoY46IANeOadIpzSfEXaBcwymkEhF8v3ICnKhps%253D" target="_blank">
  <img src="https://aka.ms/deploytoazurebutton"/>
</a>
<p>
  
# Prod - Fairfax

<a href="https://portal.azure.us/?microsoft_azure_marketplace_itemhidekey=cuidCustomDeployment2/Microsoft.Template/#create/uri/https%3A%2F%2Fstartstopv2prod.blob.core.windows.net%2Fartifacts%2Fazuredeploy.json%3Fsv%3D2019-02-02%26st%3D2020-06-24T00%253A29%253A01Z%26se%3D2030-06-25T00%253A29%253A00Z%26sr%3Dc%26sp%3Dr%26sig%3Db8ZTNoY46IANeOadIpzSfEXaBcwymkEhF8v3ICnKhps%253D" target="_blank">
  <img src="https://aka.ms/deploytoazurebutton"/>
</a>

<p>

# Dev 

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://ms.portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fstartstopv2dev.blob.core.windows.net%2Fartifacts%2Fazuredeploy.json%3Fsv%3D2019-02-02%26st%3D2020-06-23T06%253A24%253A52Z%26se%3D2027-06-24T06%253A24%253A00Z%26sr%3Dc%26sp%3Drl%26sig%3DGgIYE%252BSCmJJj2UZk86iTpoicN7LFfTXpQNaCd1cVbGM%253D)


# Whitelist URL's
1) To whitelist url's open this site in your browser: https://sasweb.microsoft.com/ \
1a)On the main page click on: <b>My Silos</b>
<img src ="images/sasweb%201.JPG" width = " 640" height= "480" >

2) Once you select My Silos, click on the Silo you are an Owner of.
<img src ="images/sasweb%202.JPG" width = " 640" height= "480" >

3) The silo you are an owner of will allow you to add URL's to its whitelist.

3a) Select <b>Request URL Allowlist</b>

<img src ="images/sasweb%203.JPG" width = " 640" height= "480" >

4) Once you open the URL Allowlist select the tab <b>Request Allowlist</b>.

4a) Add the following URLS:  

4b) https://microsoftit.visualstudio.com/OneITVSO/_wiki/wikis/OneITVSO.wiki/9188/Start-Stop-VMs-during-off-hours-Azure-Marketplace-(V2) 

4c) https://github.com/microsoft/startstopv2/blob/master/README.md

4d) Click add allowlist to whitelist these.

<img src ="images/sasweb%203.JPG" width = " 640" height= "480" >




# Deployment steps
1) The following URL's must be whitelisted: https://github.com/microsoft/startstopv2 and https://github.com/. Follow the above steps on how-to whitelist the urls.
2) Due to Subscription level role assignment a SAW Device must be used to elevate just in time privileges to start deployment.  
3) Role Assignment for Azure Functions managed identity must be added at the subscription level on the secondary subscriptions.



# Auto Upgrade
Users can opt in to get the latest version of the function app installed instantly.
Perform the following steps to automatically sync changes to the master branch to your function app:

## Connecting to Github

1. Open the Function App from your deployment.
2. Open Deployment Center
3. Select 'External Git'
4. Select 'App Service Build Service'
5. On the configure page enter:
  * Repository: https://github.com/microsoft/startstopv2
  * Branch: master
  * Repository Type: Git
  * Private Repository: No
6. Click Finish

## Creating Webhook
1. Click 'Deployment Credentials and then 'Download Publish Profile'
2. Create a URL of the following form:

https://$X:Y@X.scm.azurewebsites.net/deploy?scmType=GitHub
where X is the 'userName' and Y is 'userPWD' in the publish settings.

3. Send a POST call to the following endpoint:
https://prod-16.centralus.logic.azure.com:443/workflows/98a49e5622064c78b5a62e344e60f5ef/triggers/manual/paths/invoke?api-version=2016-10-01&sp=%2Ftriggers%2Fmanual%2Frun&sv=1.0&sig=oqXG1M5FxtSkA2Xi4ZiirmBroTScjrGeMWk1uYAuv3k
with a body of the form:

"{'url': 'Z'}" where Z is the URL created in step 2.

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
