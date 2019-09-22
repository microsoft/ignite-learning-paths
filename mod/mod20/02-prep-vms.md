# Deploying the data sources (Virtual Machines, IaaS)

In order to install the virtual machines that will be used as the source of the migration for the demo, follow these steps:

1. Click on the button below to open the deployment page.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Flbugnion%2Ftempo-mod20-templates%2Fmaster%2Fazuredeploy-vms.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

2. In the template page, enter the following information:

- Subscription: Select the subscription in which the resources should be deployed.
    
- Resource group: We recommend creating a new resource group. Try to name it consistently, for example we recommend `mod20[prefix]vms` where `[prefix]` is the unique prefix that you [prepared here](#prefix).
    
- Location: Enter the location that you selected for this session's demos, for example `East US 2` or `West Europe`.

> Note that not all locations allow running all the services needed in this demo.

- Prefix: A **unique prefix** that will be used to render each resource name unique.

> IMPORTANT: Because of some limitations in some services' names, the prefix should be **4 characters long maximum**. You should only use **the letters A-Z, a-z or the digits 0-9** for the prefix.

- Username: The username that will be used to log into the virtual machines. We recommend sticking to a consistent username and password. For convenience, this field is pre-populated with the value `tailwind` but you can change it if you want.

- Password: The password that will be used to log into the virtual machines. We recommend sticking to a consistent username and password. For convenience, this field is pre-populated with the value `traderstraders42.` but you can change it if you want.

After you entered the values, check the `Terms and conditions` checkbox and click on Purchase.

![Deployment template](./images/2019-09-22_22-39-05.png)

> Depending on a number of factors, the deployment should take about XX minutes.

> **TODO**
> - Update the number of minutes needed for the deployment.
> - Enter a description of steps needed to verify the deployment while it is running.
