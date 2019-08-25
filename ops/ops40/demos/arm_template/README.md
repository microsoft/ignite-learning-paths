# Azure Resource Manager Template Demo

In this demo, an Azure Resource Manager template is examined, updated, and deployed.

## Prerequisites

The template used in this demo needs to have been pre-deployed before the demo. If you have deployed the demo environment for OPS40, this should have already been done for you. If not, this button can be used to deploy the template.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fneilpeterson%2Ftailwind-reference-deployment%2Fmaster%2Fdeployment-artifacts-standalone-vm%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

## Examine the template

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

# Add storage account

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

<insert image>