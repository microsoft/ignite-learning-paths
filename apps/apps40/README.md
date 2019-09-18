# APPS40 Consolidating Infrastructure with Azure Kubernetes Service

# Tailwind Traders AKS

In order to deploy this template, you need an Azure Service Principal. If needed, use the `az ad sp create-for-rbac` command to create the service principal. See [az ad sp create-for-rbac](https://docs.microsoft.com/en-us/cli/azure/ad/sp?WT.mc_id=none-github-nepeters&view=azure-cli-latest#az-ad-sp-create-for-rbac) for more information.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscotty-c%2Fignite-learning-paths%2Fmaster%2Fapps%2Fapps40%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

## Provider registration

The Tailwind Traders application uses many Azure services. In some cases, if a service has not yet been used in your subscription, a provider registration may be needed. The following commands will ensure your subscription is capable of running the Tailwind Traders application.

```
az provider register --namespace Microsoft.OperationalInsights
az provider register --namespace Microsoft.DocumentDB
az provider register --namespace Microsoft.DBforPostgreSQL
az provider register --namespace Microsoft.OperationsManagement
az provider register --namespace Microsoft.ContainerService
az provider register --namespace Microsoft.Sql
az provider register --namespace Microsoft.ContainerRegistry
az provider register --namespace Microsoft.insights
```

## Connect to deployment

To validate that the deployment has completed, select the Azure Container Instance.

![alt text](./images/aci.jpg)

Select **Containers**. Once the container state has changed from **Running** to **Terminated**, the deployment automation has completed. Select logs.

![alt text](./images/logs.jpg)

Scroll to the bottom of the logs to retrieve both the application URL and the command needed to connect to the Kubernetes cluster.

![alt text](./images/connection.jpg)
