# Using pre-built AI to understand images

In this demonstration, we will use Azure Computer Vision to detect the type of
object an image represents. 

First, we will use the Computer Vision online web-form to upload an image and
observe the results.

Then, we will use the Computer Vision API to collect the same information
programatically, using curl.

## Getting Set up

### Create Cognitive Services resources

1. Download "CV Training Images.zip" to your local machine, and expand the zip
   file. This will create a folder "CV Training Images" with the following
   subfolders:

* drills
* hammers
* hard hats
* pliers
* screwdrivers

These images will be used to test the Computer Vision service and create a model
with the Custom Vision service.

All images were sourced from Wikimedia Commons and used under their respective
Creative Commons licenses. See the file [ATTRIBUTIONS.md](Attributions.md) for
details.

2. Sign up for an Azure Subscription

If you don't already have an Azure subscription, you can [sign up
here](https://azure.microsoft.com/free/?WT.mc_id=msignitethetour2019-github-aiml20)
and also get $200 in free Azure credits to use. 

3. Find your Azure Subcription ID

TODO: Provide details on finding your tenant ID here.

### Set up VS Code

* How to install
* Azure Account extension, configure

### Deploy the Tailwind Traders website

TODO: Describe how to deploy the website from the repo, and get a link to the
live website to demonstrate.

### Load the simple ONNX model

We will replace the products.onnx file in the Web app with a version that only recognizes two object categories: "hammer" and "wrench".

1. In the Azure Portal, visit your tailwind-traders-standalone resource group

1. Click the "onnx" Web App resource

1. Under Development Tools, Click Advanced tools, then click "Go" in right pane to launch Kudu.

1. In the main menu bar, Click Debug Console > PowerShell

1. Browse to site / wwwroot / Standalone / Onnxmodels

1. With Explorer, open the ONNX / simple model folder from your AIML20 repo

1. Drag products.onnx into the LEFT HALF of the Kudu window. 

1. Restart the web server. Return to the "onnx" Web App resource and click "Restart".

# Demos

## Defining the problem: Shop by Photo is broken

1. Visit the Tailwind Traders website you deployed earlier. There is a pre-deployed version at:

https://tailwind-traders-standalone-onnx.azurewebsites.net/

2. Scroll down to the "Shop by Photo" section of the website

3. Click "Shop by Photo"

1. In your AIML20 repo, select CV training images / hammers / Carpenters Hammer.jpg

1. It correctly identifies it as a hammer. Yay!

1. Return to home page and click "Shop by Photo" again

4. In your AIML20 repo, select CV training images / screwdrivers / Big Flat Screwdriver.jpg

5. Oh no! It identifies it as a hammer as well. We'll fix that later, but first, let's understand why it failed.

## Using Computer Vision via the Web interface

Let's try using computer vision on a picture of a hardware product. If we can
identify a product that Tailwind Traders sells by name, we can search for that
name in the catalog for the "Shop by Photo" app.

1. Visit the Computer Vision webpage at
   [https://azure.microsoft.com/en-us/services/cognitive-services/computer-vision/](https://azure.microsoft.com/en-us/services/cognitive-services/computer-vision/?WT.mc_id=msignitethetour2019-github-aiml20)

2. Scroll down to the "Analyze an Image" section. It looks like this:

!["Computer Vision: Analyze an Image"](img/Computer%20Vision%20Analyze%20an%20Image.png)

3. Click the "Browse" button, and choose "man in hardhat.jpg" from the "test
   images" folder in "CV Training Images".

4. After a moment, the analysis of your image will appear in the right pane. It
   looks like this:

```
FEATURE NAME:	VALUE

Objects	[ { "rectangle": { "x": 138, "y": 27, "w": 746, "h": 471 }, "object": "headwear", "confidence": 0.616 }, { "rectangle": { "x": 52, "y": 33, "w": 910, "h": 951 }, "object": "person", "confidence": 0.802 } ]

Tags	[ { "name": "man", "confidence": 0.999212 }, { "name": "headdress", "confidence": 0.99731946 }, { "name": "person", "confidence": 0.995057464 }, { "name": "clothing", "confidence": 0.991814733 }, { "name": "wearing", "confidence": 0.9827137 }, { "name": "hat", "confidence": 0.9691986 }, { "name": "helmet", "confidence": 0.9227209 }, { "name": "headgear", "confidence": 0.840476155 }, { "name": "personal protective equipment", "confidence": 0.8358513 }, { "name": "looking", "confidence": 0.832229853 }, { "name": "hard hat", "confidence": 0.8004248 }, { "name": "human face", "confidence": 0.785058737 }, { "name": "green", "confidence": 0.774940848 }, { "name": "fashion accessory", "confidence": 0.706475437 } ]

Description	{ "tags": [ "man", "headdress", "person", "clothing", "wearing", "hat", "helmet", "looking", "green", "jacket", "shirt", "standing", "head", "suit", "glasses", "yellow", "white", "large", "phone", "holding" ], "captions": [ { "text": "a man wearing a helmet", "confidence": 0.8976638 } ] }

Image format	"Jpeg"

Image dimensions	1000 x 1000

Clip art type	0

Line drawing type	0

Black and white	false

Adult content	false

Adult score	0.0126242451

Racy	false

Racy score	0.0156497136

Categories	[ { "name": "people_", "score": 0.69140625 } ]

Faces	[ { "age": 37, "gender": "Male", "faceRectangle": { "top": 419, "left": 363, "width": 398, "height": 398 } } ]

Dominant color background	"White"

Dominant color foreground	"White"

Accent Color	#90A526
```

(Note, the above analysis may change in the future: the Computer Vision model is
updated regularly.)

Note that in the first "Objects" result, two objects "headwear" and "person" are
detected, and their locations in the image is given. The object we want to
detect is classified "headwear", but for our application we need a more specific
classification: "hard hat". However "hard hat" is not one of the object types
that Computer Vision currently detects. (We'll address this problem with Custom
Vision, later.) Also note that a confidence score is given for each object
classification.

The second "Tags" result gives a list of labels associated with the entire
image. The tag with the highest confidence (listed first) is "man", which
doesn't help us much. The second tag, "headdress", is not exactly what we are
looking for either.

The other responses are also interesting, but we won't focus on them for our
demo. But take a look at what's included:

* A caption for the photo ("a man wearing a helmet") in the Description field.

* Image features (is it black and white? a line drawing?)

* Details of any faces detected in the image (identified as a 37-year-old male in this case)

* A score for the content of the image: is it "Adult" or "Racy"?

* Color analysis for the image: the dominant foreground, accent, and background colors.

We're really only interested in the "Tags" field for our purposes, so we'll find
out how to extract that programatically in the next section.

## Using Computer Vision via the API

You can [control Computer Vision programatically using its REST
API](https://docs.microsoft.com/en-us/azure/cognitive-services/computer-vision/vision-api-how-to-topics/howtocallvisionapi?WT.mc_id=msignitethetour2019-github-aiml20).
You can do this from just about any language or application that has access to
the Web, but we will use [curl](https://curl.haxx.se/), a common command-line application for interfacing
with URLs and collecting their outputs. The curl application comes pre-installed
on most Linux distributions and in recent versions of Windows 10 (1706 and
later). 

### Generating Keys for use with Custom Vision

To access the Computer Vision REST API you will need keys to validate your
access. You can [create keys interactively with the Azure
Portal](https://docs.microsoft.com/en-us/azure/cognitive-services/cognitive-services-apis-create-account?tabs=multiservice%2Clinux&WT.mc_id=msignitethetour2019-github-aiml20),
but here we will do it programatically using the Azure Command Line Interface.
You can [install the Azure
CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&WT.mc_id=msignitethetour2019-github-aiml20)
on your local Windows, MacOS or Linux machine. If you don't have it installed,
you can also launch the [Azure Cloud
Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/overview?WT.mc_id=msignitethetour2019-github-aiml20)
and run these commands from a browser window. (VS Code users can also use the
[Azure
Account](https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account)
extension to run Cloud Shell in a Terminal window.)

We will cut-and-paste commands from file [vision_demo.sh](vision_demo.sh).

At the command line on your local machine with Azure CLI installed, or in Azure
Cloud Shell, run the commands in the section "Create a key". These commands will:

1. Log into your Azure subscription (this step is unneccessary if using Cloud Shell)
2. Create an Azure Resource Group
3. Create a Cognitive Service key
4. Find the key
5. Use CURL to analyze two images

TODO: Finish

### DEMO: Custom Vision

TODO:
Develop new model in Custom Vision
Export as ONNX file

### DEMO: ONNX in TWT

1. Browse to https://lutzroeder.github.io/netron/, Click Open Model

2. Open ONNX / Custom Model / products.onnx

3. Scroll through the neural network and note:

 - it's large
 - at the top, is a 224x224 image as input (dirty secret: computer vision models have pretty poor vision)
 - add the bottom, it outputs 5 values, these are the confidence scores for our class labels

Next, drop the ONNX file we exported into TWT filesystem

1. In the Azure Portal, visit your tailwind-traders-standalone resource group

1. Click the "onnx" Web App resource

1. Under Development Tools, Click Advanced tools, then click "Go" in right pane to launch Kudu.

1. In the main menu bar, Click Debug Console > PowerShell

1. Browse to site / wwwroot / Standalone / Onnxmodels

1. With Explorer, open the ONNX / custom model folder from your AIML20 repo

1. Drag products.onnx into the LEFT HALF of the Kudu window. 

1. Restart the web server. Return to the "onnx" Web App resource and click "Restart".

Rerun Shop by Photo, upload CV training images / screwdrivers / Big Flat Screwdriver.jpg. Now it works!







