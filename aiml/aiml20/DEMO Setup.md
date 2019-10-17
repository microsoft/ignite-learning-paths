# Setup for AIML20 demos

These tasks were performed ahead of time for the AIML20 presentation. Follow
these same steps to prepare for the remaining demo scripts.

## Sign up for an Azure Subscription

If you don't already have an Azure subscription, you can [sign up
here](https://azure.microsoft.com/free/?WT.mc_id=msignitethetour2019-github-aiml20)
and also get $200 in free Azure credits to use. 

## Find your Azure Subcription ID

In the [Azure Portal](https://portal.azure.com), sign in and click on
"Subscriptions" in the left menu bar. Click on the Subscription Name you will be
using, and copy the "Subscription ID" shown there. You'll need it later when you
create resources.

Alternatively, run `az account show` in the Azure CLI and copy the "id" value
shown.

## Start fresh.

 If you've run the demos before, delete these resource groups if they exist:
 
 - aiml20-demo

 You can use the Azure Portal, or run this command in the Azure CLI:

 ```sh
 az group delete --name aiml20-demo
 ```

## Deploy the Tailwind Traders website.

Visit the [TailwindTraders-Website](https://github.com/Microsoft/TailwindTraders-Website) Github repository, and click the "Deploy to Azure" button.

You will need the homepage of the deployed website; TODO here is how to find
it.

NOTE: Temporary forks for
[ONNX](https://github.com/anthonychu/TailwindTraders-Website/tree/add-image-classifier)
and [Personalizer](https://github.com/limotley/TailwindTraders-Website) demos
are needed for now.

## Configure Visual Studio Code

Install the extension [Azure
Account](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account).
(On Windows, you will also need to [install node.js](https://nodejs.org/).) Log
into Azure with the "Azure: Sign In" command (use Control-Shift-P to open the
Command Palette). To run Azure CLI commands from a script in VS Code, use
"Terminal: Run Selected Text in Azure Terminal" to copy commands.)

Alternatively you can [install the Azure
CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=msignitethetour2019-github-aiml20)
on your local Windows, MacOS or Linux machine. If you don't have it installed,
you can also launch the [Azure Cloud
Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/overview?WT.mc_id=msignitethetour2019-github-aiml20)
and run these commands from a browser window. 

## Prepare Visual Studio for demo

- Open vision_demo.sh
- launch a Cloud Shell with "Azure: Open Bash In Cloud Shell". (If you prefer, you can use the Azure CLI locally.)   

## Open browser pages ready to demo.

* The Tailwind Trader app deployment(s):
    * ONNX: https://tailwind-traders-standalone-onnx.azurewebsites.net/
    * Personalizer: https://tailwindtraderss3wx6j2hv652e.azurewebsites.net/
* https://portal.azure.com (browse to resources)  
* https://azure.microsoft.com/en-us/services/cognitive-services/computer-vision/
* https://customvision.ai
* https://lutzroeder.github.io/netron/

## Download image files to local machine

Download "CV Training Images.zip" to your local machine, and expand the zip
file. This will create a folder "CV Training Images" with the following
subfolders:

* drills
* hammers
* hard hats
* pliers
* screwdrivers

These images will be used to test the Computer Vision service and create a model
with the Custom Vision service.

These images were sourced from Wikimedia Commons and used under their respective
Creative Commons licenses. See the file [ATTRIBUTIONS.md](Attributions.md) for
details.

Also download the folder "test images". These images will not be used in
training, but will be used to test that our models are working.

## Next Step

[Computer Vision](DEMO%20Computer%20Vision.md)