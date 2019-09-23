#!/bin/sh

# Create a Cognitive Services key and use it with Computer Vision

## Create a key
## Full details here: https://docs.microsoft.com/en-us/azure/cognitive-services/cognitive-services-apis-create-account-cli

## Log in to the Azure CLI (not needed for Cloud Shell)
az login

## Create a resource group to hold keys
az group create \
    --name aiml20-demo \
    --location westus2

## Create an omnibus CognitiveServices account key
az cognitiveservices account create \
    --name aiml20-cs-resource \
    --resource-group aiml20-demo \
    --kind CognitiveServices \
    --sku S0 \
    --location westus2 \
    --yes    

## Display the key
az cognitiveservices account keys list \
    --name aiml20-cs-resource \
    --resource-group aiml20-demo

# Send a request with Curl

## Analyze: A dummy wearing a safety hat
## https://raw.githubusercontent.com/revodavid/ignite-learning-paths/master/aiml/aiml20/CV%20training%20images/hard%20hats/Dummy%20with%20safety%20gear.jpg
curl -H "Ocp-Apim-Subscription-Key: 82e4f7dabcc64a978a17b0a55ac523e1" \
      -H "Content-Type: application/json" \
      "https://westus2.api.cognitive.microsoft.com/vision/v2.0/analyze?visualFeatures=Categories,Description&details=Landmarks&language=en" \
      -d "{\"url\":\"https://raw.githubusercontent.com/revodavid/ignite-learning-paths/master/aiml/aiml20/CV%20training%20images/hard%20hats/Dummy%20with%20safety%20gear.jpg
\"}"   

## Analyze: A picture of a hard hat
## https://raw.githubusercontent.com/revodavid/ignite-learning-paths/master/aiml/aiml20/CV%20training%20images/hard%20hats/Dummy%20with%20safety%20gear.jpg
curl -H "Ocp-Apim-Subscription-Key: 87a80369996f4ff0a368cdb337ab71a6" \
      -H "Content-Type: application/json" \
      "https://westus2.api.cognitive.microsoft.com/vision/v2.0/analyze?visualFeatures=Categories,Description&details=Landmarks&language=en" \
      -d "{\"url\":\"https://raw.githubusercontent.com/revodavid/ignite-learning-paths/master/aiml/aiml20/CV%20training%20images/hard%20hats/Hard%20hat%2020111111.jpg\"}"   


# Delete the resource group and associated resources
az group delete --name aiml20-demo
