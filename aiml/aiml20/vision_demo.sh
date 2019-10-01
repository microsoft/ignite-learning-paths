#!/bin/sh

###
### Create a Cognitive Services key and use it with Computer Vision
###

### Create a key

## Full details here: https://docs.microsoft.com/en-us/azure/cognitive-services/cognitive-services-apis-create-account-cli

## 1. Log in to the Azure CLI (not needed for Cloud Shell)
az login

## 2. Create a resource group to hold keys
az group create \
    --name aiml20-demo \
    --location westus2

## 3. Create an omnibus CognitiveServices account key
az cognitiveservices account create \
    --name aiml20-cs-resource \
    --resource-group aiml20-demo \
    --kind CognitiveServices \
    --sku S0 \
    --location westus2 \
    --yes    

## 4. Display the key
# This will display two keys. 
# Copy the "key1" value to your clipboard, without the quotes.
# It will look something like this: c8e5546e8dab4b7a91590b252a9b16fd
az cognitiveservices account keys list \
    --name aiml20-cs-resource \
    --resource-group aiml20-demo

### Send a request with Curl

## Analyze: A dummy wearing a safety hat
## https://raw.githubusercontent.com/revodavid/ignite-learning-paths/master/aiml/aiml20/CV%20training%20images/hard%20hats/Dummy%20with%20safety%20gear.jpg

## 5. Call the Computer Vision REST API
# Replace key in the first line below with the key obtained in step 4

curl -H "Ocp-Apim-Subscription-Key: YOUR-KEY-HERE" \
      -H "Content-Type: application/json" \
      "https://westus2.api.cognitive.microsoft.com/vision/v2.0/analyze?visualFeatures=Categories,Description&details=Landmarks&language=en" \
      -d "{\"url\":\"https://raw.githubusercontent.com/revodavid/ignite-learning-paths/master/aiml/aiml20/CV%20training%20images/hard%20hats/Dummy%20with%20safety%20gear.jpg
\"}"   

## Analyze: A picture of a hard hat
## https://raw.githubusercontent.com/revodavid/ignite-learning-paths/master/aiml/aiml20/CV%20training%20images/hard%20hats/Dummy%20with%20safety%20gear.jpg
curl -H "Ocp-Apim-Subscription-Key: YOUR-KEY-HERE" \
      -H "Content-Type: application/json" \
      "https://westus2.api.cognitive.microsoft.com/vision/v2.0/analyze?visualFeatures=Categories,Description&details=Landmarks&language=en" \
      -d "{\"url\":\"https://raw.githubusercontent.com/revodavid/ignite-learning-paths/master/aiml/aiml20/CV%20training%20images/hard%20hats/Hard%20hat%2020111111.jpg\"}"   


# Delete the resource group and associated resources
az group delete --name aiml20-demo
