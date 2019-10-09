# AFUN95: Figuring Out Azure Functions

Tailwind Traders is curious about the concept behind “serverless” computing – the idea that they can run small pieces of code in the cloud, without having to worry about the underlying infrastructure. In this session, we’ll cover the world of Azure Functions, starting with an explanation of the servers behind serverless, exploring the languages and integrations available, and ending with a demo of when to use Logic Apps and Microsoft Flow. 

# TODOs (delete when all done)

- [ ] Deploy a Mid-completed Logic App
- [ ] ARM template to deploy the Function
- [ ] Add a **Deploy to Azure** button to deploy everything

## Demo Setup

The following steps are necessary to prepare for AFUN95 demos.

- Until the magic button is done we need to do a few steps manually
- Create an Node.js Function App
- Create an Empty Logic App




## Demo Presentation

> You should have a few things open a ready: 
>
> - PowerPoint
> - Browser Tab - Portal Azure - Dashboard/ home
> - Browser Tab - Portal Azure - Function App (with out any Functions)
> - Browser Tab - Portal Azure - Logic App Overview blade 
> - Browser Tab - GitHub - this document. (https://github.com/microsoft/ignite-learning-paths/tree/afun95/afun/afun95)
> - ZoomIt (or another application that zoom your screen) should be running
>   

### Demo 1 - Logic App Demo

Some Simple Logic App will be already deployed. We will need add an action and try it.
something like trigger on new file in One Drive and do something.

### Demo 2 - Javascript Function Demo

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

[![Deploy to Azure](https://img.shields.io/badge/Deploy%20To-Azure-blue?logo=microsoft-azure)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fignite-learning-paths%2Fmaster%2Fafun%2Fafun95%2Fdeployment%2FdeployAzure.json)

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fignite-learning-paths%2Fmaster%2Fafun%2Fafun95%2Fdeployment%2FdeployAzure.json" target="_blank"><img src="https://azuredeploy.net/deploybutton.png"/></a>

- Open the ARM template in `adeployment/deployAzure.json`
- Examine the template (MORE TO COME)
- Once deployment is done open the code...

Congrats all demos are done.

## Become a Presenter

Visits the [Trained Presenters](https://github.com/microsoft/ignite-learning-paths-training/tree/master/afun/afun95) to learn how to become a Trained Presenters on this content.
