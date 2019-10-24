# AFUN95: Figuring Out Azure Functions

Tailwind Traders is curious about the concept behind “serverless” computing – the idea that they can run small pieces of code in the cloud, without having to worry about the underlying infrastructure. In this session, we’ll cover the world of Azure Functions, starting with an explanation of the servers behind serverless, exploring the languages and integrations available, and ending with a demo of when to use Logic Apps and Microsoft Flow. 


## Demos Deployment

To deploy all the resources required for all the demos of this session you just need to click on the **Deploy to Azure** button. Create a new Resource Group (ex: AFUN95demo), select the location of your choice, and check the agreement checkbox, at the bottom of the page. Once Ready click the **Purchase** button to deploy.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fignite-learning-paths%2Fmaster%2Fafun%2Fafun95%2Fdeployment%2FdeployAzure.json" target="_blank"><img src="https://azuredeploy.net/deploybutton.png"/></a>

![deployafun95][deployafun95]

Once the deployment is completed you should have:

- App Service plan
- 2x Azure Function (App Service) 
- Storage account
- Logic app

> Note: There are two Azure functions, but we only need one. The other, with *funcbck66tmf* in the name, was created as a backup for the presenter.

![All Resources][allResources]

## Demo 1 - Azure Logic App Demo

In this demo, we will see an Azure Logic App triggered by an HTTP Get command creating a file in a OneDrive folder with dynamic content base on the parameter received via the HTTP call.

### Azure Logic App

Navigate to the Azure Portal (portal.azure.com). Open the Resource Group deployed previously (ex: AFUN95demo). Select the Azure Logic App. On the Azure Logic App blade, click the **Logic app designer** from the left panel. Alternatively, you can also click **Edit** in the top menu. 

We are now in the Designer view. There is currently two boxes: an HTTP Trigger, and a OneDrive action. Before we can try it we need to give access to the Azure Logic App to your OneDrive.

> Note that there is a little icon ⚠️ to show that this action required our attention

Click on the second Box, named Connections. There is a message saying: "Invalid connection". It's normal it wasn't configured. Let's fix that. Click on the **Add new** button. This will popup a login window, where you will need to enter your OneDrive credentials.

By default, the Azure Logic App while creates the file into the folder */IgniteDemo*. If you don't have it, create it from your OneDrive or select another folder.

### Add an Action

A workflow trigger by an HTTP trigger is incomplete without an HTTP Response. Let's add one. Click the **+ New step** bellow the last step *Create File*. In the search bar type `Response` then select the **Response Request**. Enter `200` as Status Code. 

For the body we will use the **dynamic content**, it's one of the great features about Azure Logic App. Each property of the previous step will be present in a dynamic menu, you just need to click on it to use them. Type `The file `. Then from the dynamic content click on **Display Name** in the OneDrive content (It's the one with the OneDrive logo on the side). Then type ` was created`.

![addResponse][addResponse]

Don't forget to save your work by clicking the **Save** button on the top of the screen.

### Testing the workflow

To execute this Azure Logic App we will need the URL to fire the Trigger. This one can be found in the trigger box. Click on the first box and copy the **HTTP GET URL**

![azure logic app url][azurelogicappurl]

Open a new tab in your favorite browser and paste the URL into the address bar. Before taping Enter we need to add a parameter.  To do this add the following code at the end of the URL.

  &salutation=Hello%20Ignite

Now Press Enter.

You should see the response we created: `The file test.txt was created`. Now open the destination folder in OneDrive and open that `test.txt` file...

Voila! Of course, you can do more complex workflow with Azure Logic App, to learn more visit [the Azure Logic Apps documentation](https://docs.microsoft.com/en-us/azure/logic-apps/?WT.mc_id=msignitethetour2019-github-afun95).

## Demo 2 - JavaScript Function Demo

In this demo, we will show how easy it is to create a new JavaScript Azure Function. We will do it from the Portal.

### How to Create a Function App

Navigate to the Azure Portal (portal.azure.com), and click the "+" sign on the top left corner, select **Function App**.

> ⚠ Don't click create button this is just to see the little information we need to get started.

See that you can create or use an existing **Resource Group**. You can select your type of **OS**, **Location**, **Runtime**, and how you **Consumption Plan**.  Just like on TV shows, we already have an Azure Function App created.

### Create our first Azure Function

Open the Resource Group deployed previously (ex: AFUN95demo). Click on the Function App that contains the word 'function' (ex: afun95demo**function**66tmf).

A Function App is like a container with multiple functions. Click the "**+**" beside Function to create our first Function. There is many different ways to create Function, but right now let's do it In-Portal; click **In-Portal**, and the **Continue** button. Click **More templates**

There is many different templates, one of each occasion. For this demo let's do an HTTP trigger, Click on **HTTP trigger**.  Change the name for `SimpleHttpTrigger`, and the *Authorization level* to `Anonymous`. Of course in a real situation, we would probably use a different configuration, but in this demo context, those will be just perfect.

> Using the name `SimpleHttpTrigger` will simplify things for demo3. However is you decide, you can change it.

### Let's Examine the code

As you can see at line 4 the function is expecting a parameter `name`

```javascript
   if (req.query.name || (req.body && req.body.name)) {
```
If you pass it it return a greeting message, otherwise it response with a message explaining that you should pass a parameter.

### Executing the Azure Function 

To get started, let's test the Azure Function directly from the Azure portal. 
    * Expand the **Test** panel on the right
    * Click the Run button, read the answer. It's working! 
    * Now delete the Request body to see the error message. Click the Run button... Notice the error message.

### Update the Azure Function     

Because the Azure Function is in JavaScript we can edit it directly in the portal. Change `Hello ` by `Hello Ignite I'm `. And click the **Save** button. 

Click on **</> Get function URL**, at the right of the buttons

![Part of the portal to get the Function Url][functionUrl]

Copy-Paste the URL in a new Browser tab, notice the error message. This is there is no parameter. When we test the Function earlier we pass the parameter in the body. Let's pass it via the querystring this time. Add `?name=YOUR_BANE` at the end of the URL, and hit Enter.

Creating, updating and using Azure Function is that easy. You are now ready to create your own! Visit [Azure Functions](https://azure.microsoft.com/en-us/services/functions/?WT.mc_id=msignitethetour2019-github-afun95) web pages to get more details, different scenarios.


## Demo 3 - Deploying from GitHub Demo

In the previous demo, we saw how easy it is to use the Azure Portal to create some Azure Function. That might be fantastic for a first experience, but in a development environment that won't scale very well. Since you probably use a Git (or another repository), let's see how to deploy the same Azure Function from an online git: GitHub.

### Deployment pieces

In the current folder of this current repository there two subfolders that we will examine:
- deployment
- functionapp-demo 

Let's start by the **deployment** subfolder. In this one, you will find two Azure Resource Manager (ARM) template. The ARM template uses a formatting really close to JSon, and it's used to create the Azure instances for our solution. Not the binaries, only the infrastructure.

Open the file `deployAzure-afun95-demo3.json`, this is the file we will use for this demo. There are four major sections to an ARM template: parameters, variables, resources, and outputs. 

```json
{
  "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "parameters": {},
  "variables": {},
  "resources": [],
  "outputs": {}
}
```

### Parameters and Variables

Parameters and Variables are very useful to create a more dynamic content. Have a look at the few parameters and variables name, we will get back to them later.

### The Resources

There it is the core of the ARM template the list of resources to create. To create an Azure Function we need a few resources: a functionapp (aka.Web/sites), an storageAccounts to save the code, and a Service Plan or "serverfarms" that describe the physical resources that will be useful and some billing options. Try to find those in elements in the template, and examine the properties. 

There is a sub-resource inside the functionApp that starts at line 88

```json
{
    "apiVersion": "2015-08-01",
    "name": "web",
    "type": "sourcecontrols",
    "dependsOn": [
        "[resourceId('Microsoft.Web/sites/', variables('funcAppName'))]"
    ],
    "properties": {
        "RepoUrl": "[variables('repoURL')]",
        "branch": "[parameters('GitHubBranch')]",
        "publishRunbook": true,
        "IsManualIntegration": true
    }
}
```

Like mentioned previously an ARM template doesn't contain any binaries. In this **sourcecontrols** resource we tell Azure to get the code into the repository defined by the variable `repoURL`. Looking back to the top of the template we can see the variable value `"https://github.com/microsoft/ignite-learning-paths.git"`.

What will append is Azure will create the list of resources and then synchronize git repository inside Azure Function to that GitHub. And this is how Azure will have our code!

### The Function Code

Inside the folder **functionapp-demo** there is information related to the FunctionApp like host environment, packages list and more. There is also a folder **SimpleHttpTrigger**, this is the code of our function. Open it and then open the file `index.js`. Do you re-cognize this code? Yes, it's our Function with a little difference in the message: "Hello, it's still me ".

### Deploy the Azure Function

To deploy the Function we will send the ARM template to define in the deployment folder to the Azure portal `#create` feature. This is done by appending the absolute path of our template to the URL of the portal. The result looks like this.

```html
https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fignite-learning-paths%2Fmaster%2Fafun%2Fafun95%2Fdeployment%2FdeployAzure-afun95-demo3.json
```
A frequent way to ease the process is to put that composed URL in an anchor. Click the Deploy to Azure anchor (or button) to start the deployment.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fignite-learning-paths%2Fmaster%2Fafun%2Fafun95%2Fdeployment%2FdeployAzure-afun95-demo3.json" target="_blank"><img src="https://azuredeploy.net/deploybutton.png"/></a>

This will open the Azure portal with a form that we saw previously. This time you should recognize the fields of the form matching the parameters of our ARM template...  If you *Forked* the GitHub Repo you can change the URL to see your changes.

You can create a new Azure Function, or updating and existing one. Updating should be faster since only what have changed will be updated.

Once the deployment is complete you can try your function!

To get more tutorials, code examples, and documentation visit the [Azure Resource Manager](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-overview?WT.mc_id=msignitethetour2019-github-afun95).


## Teardown Instructions

Navigate to the Azure Portal and delete the Azure Resource Group (ex: AFUN95demo) you created earlier. Deleting the Resource Group will delete all resources within. Once the command is started you don't need to way, the command is been executed in Azure. \

> Note: It's always a good idea to check again after a few hours or the next day to be sure you didn't forget a Resource Group.

## Become a Trained Presenter

Visits the [Trained Presenters](https://github.com/microsoft/ignite-learning-paths-training/tree/master/afun/afun95) to learn how to become a Trained Presenters on this content.


[allResources]: assets/all-afun95-resources.png
[deployafun95]: assets/deployafun95.png
[azurelogicappurl]: assets/azurelogicappurl.png
[addResponse]: assets/addResponse.png
[functionUrl]: assets/functionUrl.png
