# APPS10: Options for Building and Running Your App in the Cloud

We’ll show you how Tailwind Traders avoided a single point of failure, using cloud services to deploy their company website to multiple regions. We’ll cover all the options they considered, explain how and why they made their decisions, then dive into the components of their implementation.  

In this session, you’ll see how they used Microsoft technologies like VS Code, Azure Portal, and Azure CLI to build a secure application that runs and scales on Linux and Windows VMs and Azure Web Apps, with a companion phone App.

## Demo Setup

The following steps are necessary to prepare for APPS10 demos.

### Software

1. Install [Visual Studio Code](https://code.visualstudio.com/) 
1. Install the [Remote extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) for VSCOde. 
1. You will need [SSH Client](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse) installed. 

### Deployments

- Deploy Full PaaS version (with Key vault)
    > Inspired from : https://gist.github.com/anthonychu/9ab34d2991fb5c1c0c29faeebbe43a51#file-tailwind-deployments-md

    <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fignite-learning-paths%2Fmaster%2Fapps%2Fapps10%2Fdeployment%2Fazure-deploy-paas.json?WT.mc_id=ignite-github-frbouche" target="_blank"><img src="https://azuredeploy.net/deploybutton.png"/></a>

- Deploy VM scale sets version 
    > Inspired from : the VM version here https://github.com/neilpeterson/tailwind-reference-deployment

    <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fignite-learning-paths%2Fmaster%2Fapps%2Fapps10%2Fdeployment%2Fazure-deploy-paas.json?WT.mc_id=ignite-github-frbouche" target="_blank"><img src="https://azuredeploy.net/deploybutton.png"/></a>

## Become a Presenter

Visits the [Trained Presenters](https://github.com/microsoft/ignite-learning-paths-training/tree/master/apps/apps10) to learn how to become a  **Trained Presenters** on this content.