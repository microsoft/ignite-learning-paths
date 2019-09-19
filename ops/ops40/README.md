# Deployment Practices for Greater Reliability

Infrastructure and software delivery methods have a direct and material impact on reliability. Manual service deployment and provisioning is slow, error-prone, and can result in incidents. Using modern continuous deployment practices and provisioning methods can reduce overhead while preventing incidents before they happen.

In this session, we will see how continuous delivery pipelines have helped Tailwind Traders and the rest of the industry deploy tested software to production environments to increase reliability. We’ll also explore modern methods for environment provisioning using infrastructure as code. As a result of attending this session, you will gain practical information on automated deployment and provisioning solutions using Azure-based technology.

## Demo environment deployment

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fignite-learning-paths%2Fmaster%2Fops%2Fops40%2Fdeployment%2Fazuredeploy.json" target="_blank">
 <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

## Delivery assets

The following asset can be used for delivering this talk:

- [PowerPoint deck]()
- [Demonstration videos]()

## Demo 1 - Azure DevOps

Address the following in this demo:

- Pipeline overview (stages, jobs, tasks, variables, and conditions)
- Show how production can be reconciled .via build ID (helm release version, pod version, and container image version)
- Add 'unit test' to pipeline and show results

```
- stage: test
  jobs:
  - job:

    variables:
      hostDB: https://ttshoppingdbxy4tce6fzj25s.documents.azure.com:443/

    pool:
      name: Hosted Ubuntu 1604

    steps:

    - task: PowerShell@2
      displayName: Install Pester
      inputs:
        targetType: 'inline'
        script: |
          Find-Module pester | Install-Module -Force

    - task: AzureCLI@1
      displayName: Generate values file for test
      inputs:
        azureSubscription: 'nepeters-azure'
        scriptLocation: 'inlineScript'
        inlineScript: |
          pwsh Deploy/Generate-Config.ps1 -resourceGroup $(aks-cluster-rg-pre-prod) -sqlPwd Password2020! -gvaluesTemplate Deploy/helm/gvalues.template -outputFile ./values.yaml

    - task: PowerShell@2
      displayName: Parse host name
      inputs:
        targetType: 'inline'
        script: |
          $content = Get-Content values.yaml
          $hostName = $content[37].split(" ")[7]

    - task: PowerShell@2
      displayName: Run Pester tests
      inputs:
        targetType: 'inline'
        script: 'invoke-pester -Script @{ Path = ''./tests/''; Parameters = @{ hostName = ''$(hostDB)'' }} -OutputFile "./test-results.xml" -OutputFormat ''NUnitXML'''

    - task: PublishTestResults@2
      displayName: Publish test results
      inputs:
        testResultsFormat: 'NUnit'
        testResultsFiles: '**/test-results.xml'
        failTaskOnFailedTests: true
```

## Demo 2 - Azure Resource Manager templates

In this demo, an Azure Resource Manager template is examined, updated, and deployed.

### Examine the template

The template file is found in the same directory as this readme and is named `azuredeploy.json`. Take a quick walk through the template, highlighting these items.

- The four sections of the tempalte (paramaters, variabls, resources, and outputs) - [docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-authoring-templates)
- Secure string parameter - [docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/template-best-practices#security-recommendations-for-parameters)
- Dependencies - [docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-define-dependencies#reference-and-list-functions)
- Copy function - [docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-multiple)
- Template extensions - [docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-use-extensions)

Not in the demo, but to mention during the demo:

- Create resources and resource groups with a template - [docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/deploy-to-subscription)
- Linked templates - [docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-linked-templates)

Once done, show the already created resources in the Azure portal. Take note that a storage account has not been deployed.

### Add storage account

Add the storage account resource to the template. It can be placed between any two existing resources.

```
{
    "type": "Microsoft.Storage/storageAccounts",
    "name": "[variables('storageAccountName')]",
    "location": "[resourceGroup().location]",
    "apiVersion": "2019-04-01",
    "sku": {
        "name": "Standard_LRS"
    },
    "kind": "StorageV2",
    "properties": {}
},
```

Add a variable which will provide the storage account name. Don't forget to add appropriate commas for valid json.

```
"storageAccountName": "[toLower(concat(variables('resourceName'), uniqueString(resourceGroup().id)))]"
```

Deploy the template with the following command. The resource group name must match the resource group in-which the template has already been deployed. Also, to prevent redeploying things, the `adminUserName` and `adminPassword` parameters should match.

```
az group deployment create --resource-group twt-standalone --template-file azuredeploy.json --parameters adminUserName=twtadmin adminPassword=Password2020!
```

Open up the Azure portal and show that the deployment is occurring and that the only affected resource is the storage account being added.

## Demo 3 - Azure Resource Change API

TODO

## Teardown instructions

When done the demo environment can be deleted using the following command:

```
az group delete --name <resource group name> --yes --no-wait
```

## Resources and Continue Learning

Here is a list of related training and documentation.

- [Design for availability and recoverability in Azure](https://docs.microsoft.com/en-us/learn/modules/design-for-availability-and-recoverability-in-azure/)
- [Create a build pipeline](https://docs.microsoft.com/en-us/learn/modules/create-a-build-pipeline/)

## Feedback loop

Do you have a comment, feedback, suggestion? Currently, the best feedback loop for content changes/suggestions/feedback is to create a new issue on this GitHub repository. To get all the details about how to create an issue please refer to the [Contributing](../../contributing.md) docs