# APPS40 Consolidating Infrastructure with Azure Kubernetes Service

# Tailwind Traders AKS

## Regions this code will work with  ​
* East US 2​
* North Europe​
* Southeast Asia​
* West Europe​
* West US 2

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
az feature register --name AvailabilityZonePreview --namespace Microsoft.ContainerService
az feature register --name AKSAzureStandardLoadBalancer --namespace Microsoft.ContainerService
az feature register --name VMSSPreview --namespace Microsoft.ContainerService
```
Then refresh you account with 

```
az provider register --namespace Microsoft.ContainerService
```

## Connect to deployment

To validate that the deployment has completed, select the Azure Container Instance.

![alt text](./images/aci.jpg)

Select **Containers**. Once the container state has changed from **Running** to **Terminated**, the deployment automation has completed. 

![alt text](./images/logs.jpg)

Scroll to the bottom of the logs to retrieve both the application URL and the command needed to connect to the Kubernetes cluster.

![alt text](./images/connection.jpg)


## Runing scale demo
To run the scaling demo you need to add the publisher 
```
cat <<EOF | kubectl apply -f -
apiVersion: batch/v1
kind: Job
metadata:
  name: rabbitmq-publish
spec:
  template:
    spec:
      containers:
      - name: rabbitmq-client
        image: jeffhollan/rabbitmq-client:dev
        imagePullPolicy: Always
        command: ["send",  "amqp://user:PASSWORD@rabbitmq.default.svc.cluster.local:5672", "300"]
      restartPolicy: Never
  backoffLimit: 4
EOF 
```
 In two new terminals you need to have the following commands running to watch the results.
 ```
 kubectl get hpa -w
 ```
 ![alt text](./images/hpa.png)

In the image above you can see that the application is scaling using the metrics from the horizontal pod autoscaler


```
kubectl get pods -o wide
```
 ![alt text](./images/pods.png)

In the image above you can see that we are scaling the pods to virtual node on ACI dynamically. 

## Availability zones
This is set up by the [deployment.json](deployment.json)
To test this is set up correctly use the following command
```
kubectl describe nodes | grep -e "Name:" -e "failure-domain.beta.kubernetes.io/zone"
```
The output should look like 
```
Name:               aks-agentpool-12493275-vmss000000
                    failure-domain.beta.kubernetes.io/zone=southeastasia-1
Name:               aks-agentpool-12493275-vmss000001
                    failure-domain.beta.kubernetes.io/zone=southeastasia-2
Name:               aks-agentpool-12493275-vmss000002
                    failure-domain.beta.kubernetes.io/zone=southeastasia-3
Name:               virtual-node-aci-linux
```

## Delete your deployment
To delete the deployment run the following 
```
az group delete -n < your resource group> -y
```
