# APPS10: Options for Building and Running Your App in the Cloud

We’ll show you how Tailwind Traders avoided a single point of failure, using cloud services to deploy their company website to multiple regions. We’ll cover all the options they considered, explain how and why they made their decisions, then dive into the components of their implementation.  

In this session, you’ll see how they used Microsoft technologies like VS Code, Azure Portal, and Azure CLI to build a secure application that runs and scales on Linux and Windows VMs and Azure Web Apps, with a companion phone App.

## TODOs (delete when all done)

- [ ] ARM template Tailwind Traders solution full PaaS with a KeyVault and a Secret
- [ ] ARM template Tailwind Traders using Scale set with a Shared Gallery
- [ ] A image used in the Scale set
- [ ] Automatically populate the in a Shared Image Gallery with the image

## Demo Setup

The following steps are necessary to prepare for APPS10 demos.

### Software

1. Install [Visual Studio Code](https://code.visualstudio.com/) 
1. Install the [Remote extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) for VSCOde. 
1. You will need [SSH Client](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse) installed. 
    * If you need a set of keys, open a terminal and execute the command `ssh-keygen -t rsa -b 2048` remember where you put the information (usually C:\Users\<USERNAME>/.ssh/ ) and your passphrase (aka password). 

### Deployments

Before we start presenting we want to have those things already deployed:

1. The Tailwind Traders solution full PaaS
2. The Tailwind Traders solution Frontend in a ScaleSet VM and backend as Services
3. Images of Tailwind Traders VM in a Shared Gallery
4. A Key Vault with a secret containing the SQL database connection

> 🚩Note: Right now there is a lot of manual steps. This will be updated. 

#### 1 - The Tailwind Traders solution full PaaS

To deploy this solution you just have to click the **Deploy to Azure**, and select *Standalone*.

[![Deploy to Azure](https://azuredeploy.net/deploybutton.svg)](https://deploy.azure.com/?repository=https://github.com/Microsoft/TailwindTraders-Website/tree/master)

<!--
- Deploy Full PaaS version (with Key vault)
    > Inspired from : https://gist.github.com/anthonychu/9ab34d2991fb5c1c0c29faeebbe43a51#file-tailwind-deployments-md

    <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fignite-learning-paths%2Fmaster%2Fapps%2Fapps10%2Fdeployment%2Fazure-deploy-paas.json?WT.mc_id=ignite-github-frbouche" target="_blank"><img src="https://azuredeploy.net/deploybutton.png"/></a>
-->

#### 2. The Tailwind Traders solution Frontend in a ScaleSet VM and backend as Services

Right now there is no deployment/ ARM done for this. Since we just need to show how to connect and scale... Create a scale sets deployment with a ubuntu vm.

- From portal.azure.com
- Click +, and type "Virtual machine scale set", then click the button create.
    * Use Ubuntu Server 18.04 LTS
    * Select SSH public key as **Authentication type**
    * 2 instances are enough
    * Allow inbound port SSH(22)
- Click Create.

> ☝ Test your connection From VSCode (See Demo to know how.)

<!--
- Deploy VM scale sets version 
    > Inspired from : the VM version here https://github.com/neilpeterson/tailwind-reference-deployment

    <a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2Fignite-learning-paths%2Fmaster%2Fapps%2Fapps10%2Fdeployment%2Fazure-deploy-paas.json?WT.mc_id=ignite-github-frbouche" target="_blank"><img src="https://azuredeploy.net/deploybutton.png"/></a>

-->

3. Images of Tailwind Traders VM in a Shared Gallery

Right now there is no real Tailwind image ready to be use in a scale set. We will fake this for now.

> 💡Always use the same location to be able to see/ use your images

- Create a simple Linux VM
- Once the VM is deployed. open the the blade in the portal
- Create an image by clicking the button capture (you can check to delete the vm once image is created)
- Click +, and type "Shared Image Gallery", then click the button create.
- Give it a name, etc. etc. Create.
- Once created, open the Shared Image Gallery.
- Click the **+ Add new image definition**
    * Give it a Name, Region (same), Invent a Publisher, Offer, SKU
    * Click the Review Create....
- Once the image definition is created, click on it.
- Click on **+ Add version**
    * Select the capture done previously as Source image 
    * Fill the rest of the form.

#### 4 - A Key Vault with a secret containing the SQL database connection

Eventually the key vault will be created and populated during the PaaS deployment. For now it's manual.

- From portal.azure.com
- Click +, and type "Key Vault", then click the button create.
- Give it a name, I suggested you create the Key Vault in the same Resource Group as the PaaS demo. This is where it will be when the process will be automatic.

Once the key vault is created we will add a secret, and populate it.
- First, we need the **SqlConnectionString** (that's our secret)
    * From the PaaS solution, select the App Service (aka. Webapp) 
    * From the left panel select Configuration
    * Click on the **SqlConnectionString** row and note the value.
- Now let's create the secret
    * Open the Key Vault
    * From the left panel, click on secret
    * Click the **+ Generate/Import**
    * Give it a name (ex: secretConStr), and paste in value the connecctionstring value (ex: Server=tcp:tailwindtraders-apps10-s...)
- Click on the Secret you created
- Click again on the secret it should look like a GUID
- Save the URL contain in the **Secret identifier**
- Re-open the App Service, and re-open the **SqlConnectionString** in the setting
- Replace the current value by: `@Microsoft.KeyVault(SecretUri=URL_FROM_KEYVAULT)`, where *URL_FROM_KEYVAULT* is replaced by the url you got from the key vault.
- Restart the App Service, and test if it's working. It should.  

## Demo Presentation

> You should have a few things open a ready:

- PowerPoint
- Browser Tab: Portal Azure Dashboard/ home
- Browser Tab: Tailwind traders website (from PaaS solution)
- Browser Tab: Scale sets Resource Group
- Browser Tab: PaaS Resource Group
- Browser Tab: Key Vault
- Visual Studio Code, with the Azure CLI to create a scale set
    ```
    az vmss create \
        -g $RGName \
        -n myScaleSet \
        --image "/subscriptions/<subscription ID>/resourceGroups/myGalleryRG/providers/Microsoft.Compute/galleries/myGallery/images/myImageDefinition/versions/1.0.0" \
        --admin-username azureuser \
        --generate-ssh-keys
  ```
- ZoomIt (or another application that zoom your screen) should be running, there is tiny stuff to show.

### Demo 1 - Let’s Create a VM 

- From Portal Azure Dashboard/ home
- Click +, and type "Virtual machine scale set", then click the button create.
- Explains a few things like the fact that you can use YOUR custom golden images...
- Magic of Ignite, you already have a scale set create.
- Switch to the Browser Tab: Scale sets Resource Group
- Explain the resources (some are missing because if a fake right now)
- Click on Virtual machine scale set
- Show the metrics (CPU, Network, etc.)
- At the top of left panel type "Scaling" in the search bar. 
    * Explain that little trick
    * Click on Scaling
- Explain how easy it is to scale MOVE THE CURSOR
- Click on the AutoScale 
- Provide some scenario scale Up by on number of item in a queue, or CPU...
- Explain that it's also very important to think about the scale down and cooldown.
- Don't save anything.

Now Let's see more details about the two VMs are suppose to have.

- Still from the scale set, click Instance from the left panel
- Here are our 2 VMS, click on one.
- Show again how that a VM like they know CPU, Memory, etc....

Let's now connect to this VM

- Click on Connect
- copy into the clipboard the `ssh username@000.000.000.000` display in the right panel.

This time to show that great extension we mention previously.

- Switch to VSCode, with the Azure CLI Code
- Mention that you showed how to create the VM and scale set using the portal but that it's of course possible to create it using ARM template or simple Azure CLI command like this one.

Let's show some Details about the Extensions in VSCode
- Open the Extension menu, type Remote to display all the remote option 

Now let's connect to the VM

- Click the lower corner of Code the **><**
- Select *Remote-SSH: Connect to Host...* option
- Paste the clipboard
- enter your passphrase

Have some fun the the VM. When it will be the real tailwind VM the app should be available from the root "/"

- Exit 
- Disconnect shh

Demo 1 is done, let's do demo 1.5.

### Demo 1.5 - Plan B: PaaS - WebApp

Now it's time to introduce the PaaS setup. Some people prefer VM other will embrace the PaaS and go VMsless

- Switch to the Browser Tab: PaaS Resource Group
- Show the different resources (avoid talking about Key vault)
- Click on App Service
- The the top panel the information available 
    * Switch to the Browser Tab: Tailwind traders website momentarily to show the website
- Show the metrics, Backup, and all other create "built-in" feature of PaaS
- At the top of left panel type "Scale" in the search bar. 
    * Explain difference between Scale Up and scale out
    * Click on scale out
- Explain how easy it is to scale MOVE THE CURSOR
- Click on the AutoScale 
- Once more quick recap of some scenario to auto-scale 
- Don't save anything.
- Open the Configuration just saying that this is you can put setting, configuration and stuff... stay brief, we will come back.

Demo 1 done. Back to slide.

### Demo 2 - Securing the app with Azure Key Vault

- From the portal, back to tab with the Configuration open
- Show a "old way" to do by showing the CosmoDB connection String **use the ZOOM**
- Now show the SQLConnectionString

Let's explain where it come from. See Before that talk you already created a Key Vaul. 

- Switch to Browser Tab: Key Vault
- Creating one is super simple `az keyvault create`, or a few textbox from the portal.
- Open Show the button to add secret
- From the left panel click on Secret, and click again.
- Provide information about where the URL come from, show the real connectionstring
- Explains the how you could do a ne version or the and expiration date.

Congratulation you just finish your last demo.

## Become a Presenter

Visits the [Trained Presenters](https://github.com/microsoft/ignite-learning-paths-training/tree/master/apps/apps10) to learn how to become a  **Trained Presenters** on this content.