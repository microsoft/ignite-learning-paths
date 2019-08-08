# Deployment Practices for Greater Reliability

[![Build Status](https://dev.azure.com/tailwindtraders-learning/tailwindtraders-learning/_apis/build/status/APP10?branchName=master)](https://dev.azure.com/tailwindtraders-learning/tailwindtraders-learning/_build/latest?definitionId=3&branchName=master)

Click this button to deploy the session environment.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fignite-learning-paths%2Fmaster%2Foprs40%2Fdeployment%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

## Session abstract

Infrastructure and software delivery methods have a direct and material impact on service reliability. Manual service deployment is slow, error-prone, and can result in reliability incidents. Using modern and continuous deployment practices your organization can reduce deployment overhead while increasing service reliability.

In this session, we will see how Tailwind Traders uses modern methods for environment provisioning using infrastructure as code. We will then see how continuous delivery pipelines can be used to deploy tested software to production environments. As a result of attending this session, you will gain practical information on automated deployment solutions using Azure-based technology.

## Delivery assets

The following asset are used for delivering this talk:

- [PowerPoint deck]()
- [Demonstration videos]()

## Demo instructions

One the environment has been deployed, select the container instances > containers > logs and scroll the bottom of the log output. Here you will find the specific command needed to connect to the new Kubernetes cluster. Copy and run this command in cloud shell.

```
az aks get-credentials --name tailwindtradersakscmmwyi53x4jls --resource-group twt-1000 --admin
```

Once connected to the cluster, run this command to list all Kubernetes deployments.

```
$ kubectl get deployments

NAME                                       READY   UP-TO-DATE   AVAILABLE   AGE
my-tt-image-classifier                     1/1     1            1           25h
my-tt-login                                1/1     1            1           25h
my-tt-mobilebff                            1/1     1            1           25h
my-tt-popular-product-tt-popularproducts   1/1     1            1           25h
my-tt-product-tt-products                  1/1     1            1           25h
my-tt-profile                              1/1     1            1           25h
my-tt-stock                                1/1     1            1           25h
my-tt-webbff                               1/1     1            1           25h
web-tt-web                                 1/1     1            1           25h
```

Identify the deployment with a name that contains login, and delete the deployment.

```
kubectl delete deployment my-tt-login
```

## Teardown instructions

When done the demo environment can be deleted using the following command:

```
az group delete --name <resource group name> --yes --no-wait
```

## Resources and Continue Learning

Here is a list of related training and documentation.

- [Design for avalibility and revoerability in Azure](https://docs.microsoft.com/en-us/learn/modules/design-for-availability-and-recoverability-in-azure/)
- [Create a build pipeline](https://docs.microsoft.com/en-us/learn/modules/create-a-build-pipeline/)

## Feedback loop

Do you have a comment, feedback, suggestion? Currently, the best feedback loop for content changes/suggestions/feedback is to create a new issue on this GitHub repository. To get all the details about how to create an issue please refer to the  [Contributing](../../contributing.md) docs