# DEMO: ONNX Deployment

In this demo, we take the ONNX file we exported in the [Custom
Vision](DEMO%20Custom%20Vision.md) demo, and deploy it to the Tailwind Traders website.

The website uses the model in `products.onnx` for the Shop by Photo app. The
uploaded image is processed by the model, which generates one of five labels:
"hammer", "drill", "pliers", "screwdriver" or "hard hat". The website searches
the product list for the generated label, and returns the results of the search.

## Load the simple ONNX model

(TIP: You can do this step ahead of time. This step is necessary if you have run
this demo before on the same deployment.)

We will replace the products.onnx file in the Web app with a version that only recognizes two object categories: "hammer" and "wrench".

1. In the Azure Portal, visit your tailwind-traders-standalone resource group

1. Click the "onnx" Web App resource

1. Under Development Tools, Click Advanced tools, then click "Go" in right pane to launch Kudu.

1. In the main menu bar, Click Debug Console > PowerShell

1. Browse to site / wwwroot / Standalone / Onnxmodels

1. With Explorer, open the ONNX / simple model folder from your AIML20 repo

1. Drag products.onnx into the LEFT HALF of the Kudu window. 

1. Restart the web server. Return to the "onnx" Web App resource and click "Restart".

## Defining the problem: Shop by Photo doesn't work right

(Note: This section was done at the beginning of the AIML20 presentation.)

1. Visit the Tailwind Traders website you deployed earlier. There is a pre-deployed version at:

https://tailwind-traders-standalone-onnx.azurewebsites.net/

1. Scroll down to the "Shop by Photo" section of the website

1. Click "Shop by Photo"

1. In your AIML20 repo, select CV training images / hammers / Carpenters Hammer.jpg

1. It correctly identifies it as a hammer. Yay!

1. Return to home page and click "Shop by Photo" again

1. In your AIML20 repo, select CV training images / screwdrivers / Big Flat Screwdriver.jpg

1. Oh no! It identifies it as a hammer as well. We'll fix that later, but first, let's understand why it failed.

## Update the ONNX model in the Tailwind Traders website

First, view the exported model in Netron:

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

Rerun Shop by Photo, upload CV training images / screwdrivers / Big Flat
Screwdriver.jpg. Now it works!

## Next Step

[Personalizer](DEMO%20Personalizer.md)


