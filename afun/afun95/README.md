# AFUN95: Figuring Out Azure Functions

Tailwind Traders is curious about the concept behind “serverless” computing – the idea that they can run small pieces of code in the cloud, without having to worry about the underlying infrastructure. In this session, we’ll cover the world of Azure Functions, starting with an explanation of the servers behind serverless, exploring the languages and integrations available, and ending with a demo of when to use Logic Apps and Microsoft Flow. 


## Demos Deployment

To deploy all the resources required for all the demos of this session you just need to click on the **Deploy to Azure** button. Create a new Resource Group (ex: AFUN95demo), select the location of your choice, and check the agreement checkbox, at the bottom the the page. Once Ready click the **Purchase** button to deploy.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ffboucher%2Fignite-learning-paths%2Fmaster%2Fafun%2Fafun95%2Fdeployment%2FdeployAzure.json" target="_blank"><img src="https://azuredeploy.net/deploybutton.png"/></a>

![deployafun95][deployafun95]

Once the deployment is completed you should have:

- App Service plan
- 2x Azure Function (App Service) 
- Storage account
- Logic app

> Note: There is two Azure function, but we only need one. The other, with *funcbck66tmf* in the name was created as backup for the presenter.

![All Resources][allResources]
...
![allResources1][allResources1]


### Demo 1 - Logic App Demo

Navigate to the Azure Portal (portal.azure.com). Open the Resource Group deployed previously (ex: AFUN95demo). Select the Azure Logic App. On the Azure Logic App blade, click the **Logic app designer** from the left panel. Alternatively you can also click **Edit** in the top menu. 

We are now in the Designer view. Their is currently two boxes: an HTTP Trigger, and an OneDrive action. Before we can try it we need to give access at the Azure Logic App to your OneDrive.

> Note that there is a little icon ⚠️ to show that this action required our attention

Click on the second Box, named Connections. There is a message saying: "Invalid connection". It's normal it wasn't configure. Let's fix that. Click on the **Add new** button. This will popup login window, where you will need to enter your OneDrive credentials.

By Default the Azure Logic App while create the file into the folder */IgniteDemo*. If you don't have it, create it from your OneDrive or select another folder.

A workflow trigger by a HTTP trigger is incomplete without an HTTP Response. Let's add one. Click the **+ New step** bellow the last step *Create File*. In the search bar type `Response` the select the **Response Request**. Enter `200` as Status Code. 

For the body we will use the **dynimic content**, it's one of the great feature about Azure Logic App. Each properties of the previous step will be present in a dynamic menu, you just need to click on it to use them. Type `The file `. Then from the dynamic content click on **Display Name** in the OneDrive content (It's the one with the OneDrive logo on the side). Then type ` was created`.

![addResponse][addResponse]

Don't forget to save your work by clicking the **Save** button on the top of the screen.

To execute this Azure Logic App we will need the URL to fire the Trigger. This one can be found into the trigger box. Click on the first box and copy the **HTTP GET URL**

![azure logic app url][azurelogicappurl]

Open a new tab in your favorite browser and paste the URL into the address bar. Before taping Enter we need to add a parameter.  To do this add the following code at the end of the URL.

  &salutation=Hello%20Ignite

Now Press Enter.

You should see the response we created: `The file test.txt was created`. Now open the destination folder in OneDrive and open that `test.txt` file...

Voila! Of course you can do more complex workflow with Azure Logic App, to learn more visit [the Azure Logic Apps documentation](https://docs.microsoft.com/en-us/azure/logic-apps/).

### Demo 2 - JavaScript Function Demo

In this demo we will show how easy it is to create a new JavaScript Azure Function. We will do it from the Portal.

- Switch to: Browser Tab - Portal Azure - Dashboard/ home
- click the "+" sign on the top left corner and select Function App
- Fill the creation form
    * **Resource Group**: create a new one
    * **Hosting plan:** Consumption Plan. 
      > Explain the difference between *Consumption Plan* pay for the time you run vs. *App Service Plan* where it's a monthly fee because the resources are always there.. but can be share with other services (ex: other function, website)
    * **Runtime:** Node.js 
    * ⚠ Don't click create show the script/ ARM template that could be generated... We will come back to this in the third demo.


Just like on TV show you already have one created.

- Switch to: Browser Tab - Portal Azure - Function App (with out any Functions)
- Quick tour of the screen, very short... show the tag Platform feature mention there tons of information over there... but we don;t need it.
- Click the "+" beside Function to create a new Function
- Mention there is many different ways to create Function, We will use VS Code in the next one, but right now let's do it In-Portal
- click **In-Portal**, and the Continue button
- click More templates
- show all template, briefly mention scenario where it could be use.
- For this demo let's do an HTTP trigger, Click on HTTP trigger.
- Rename HttpTrigger1, and change the *Authorization level* to `Anonymous`
- Examine the code... it's expecting a parameter name... return Hello 
- Let's test it In the portal
    * Expand the **Test** panel on the right
    * Click the Run button, read the answer
    * Delete the Request body to see the error message, Click the Run button
    * Notice the error message... 
- Because we are in JavaScript we can change the code. Change `Hello ` by `Hello Ignite I'm `
- Click on **</> Get function URL**  
- Copy-Paste the URL in a new Browser tab, notice the error message.
- Add `?name=YOUR_BANE to the url
- Wave at the audience you successfully finish your second demo.



### Demo 3 - Deploying from GitHub Demo

Let's now deploy the same Azure Function from GitHub

- Switch to : Browser Tab - GitHub - this document.
- examine folder **functionapp-demo** it the same function that previously.
- Open the file `functionapp-demo/afun95demoHttpTrigger/index.js` and change the code. Change `Hello Ignite I'm ` by `Hello again Ignite!!! I'm `
- Commit
- Click the following button. Let's deploy we will explain how it works while it's deploying.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Ffboucher%2Fignite-learning-paths%2Fmaster%2Fafun%2Fafun95%2Fdeployment%2FdeployAzure-afun95-demo3.json" target="_blank"><img src="https://azuredeploy.net/deploybutton.png"/></a>

- Open the ARM template in `deployment/deployAzure-afun95-demo3.json`
- Examine the template (MORE TO COME)
- Once deployment is done open the code...

Congrats all demos are done.

## Become a Presenter

Visits the [Trained Presenters](https://github.com/microsoft/ignite-learning-paths-training/tree/master/afun/afun95) to learn how to become a Trained Presenters on this content.



[allResources]: ../assets/all-afun95-resources.png
[allResources1]: afun/afun95/assets/all-afun95-resources.png
[deployafun95]: ../assets/deployafun95.png
[azurelogicappurl]: ../assets/azurelogicappurl.png
[addResponse]: ../assets/addResponse.png
