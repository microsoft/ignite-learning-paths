# MOD30: Enhancing Web Applications with Cloud Intelligence

Tailwind Traders has implemented development frameworks, deployment strategies, and server infrastructure for their apps. But now that they are on the cloud it’s time to extend functionality by tapping into powerful services that automatically scale and run exactly where and when they need them. This includes image resizing, messaging, integration with social media and tapping into cloud intelligence for image identification.

In this session, we’ll create a set of routines that run on Azure Functions, respond to events in Azure Event Grid, and integrate cloud services with Azure Logic Apps. We’ll also use Azure Cognitive Services to add AI capabilities and Xamarin for a mobile app.

## Demo Setup

The following steps are necessary to prepare for MOD30 demos.

### Software

1. Install [Node.js](https://nodejs.org) LTS
2. Install [artillery](https://artillery.io/): `npm i -g artillery`
3. Install [Visual Studio 2019 Preview](https://visualstudio.microsoft.com/?WT.mc_id=msignitethetour2019-github-mod30) with the Azure/cloud workloads (for functions)
4. (Optional) Install [Storage Explorer](https://docs.microsoft.com/azure/vs-azure-tools-storage-manage-with-storage-explorer?tabs=windows&WT.mc_id=msignitethetour2019-github-mod30)

### Deployments

1. Provision the Tailwind Traders monolith app available [here](https://gist.github.com/anthonychu/9ab34d2991fb5c1c0c29faeebbe43a51)
2. Deploy the MOD30 Assets: [![Deploy to Azure](https://azuredeploy.net/deploybutton.png)](https://azuredeploy.net/?repository=https://github.com/microsoft/ignite-learning-paths/tree/master/mod/mod30)
    > **Note:** give it a unique prefix it with, i.e. `mod30xyz` should replace `mod30`, and hereafter assume `mod30-demo` translates to `mod30xyz-demo`
3. Navigate to the `azureeventgrid` connection, click "Edit API connection" then click `Authorize` to authorize the connection
4. Publish the `Mod30Functions` app to the deployed `mod30-app` endpoint.

### Azure Portal

Create a custom dashboard for the session. (Tip: use [this link](https:/aka.ms/publicportal) to ensure you are using the public portal.)

Pin the following items for easy reference:

* `mod30-demo` function app
* `mod30demostorage` storage
* `mod30-app` function app
* `mod30-cognitive-vision` Computer Vision
* `mod30-caption` logic app

## Demo: Serverless for Elastic Scale

1. Use the empty `mod30-demo` variant of the function
2. Create an HTTP Trigger (not the Webhook quick start, use "additional templates")
3. Mention function security types and choose anonymous
4. Open application insights -> Live Metrics Stream (collapse outgoing requests and general health)
5. Hit the endpoint (either via Test or copy/paste URL, this is preferred so you can capture the endpoint) and show the live metric
6. Point out the "servers" running
7. Run `artillery quick --count 100 -n 100 {endpoint}`
8. Show auto-scale working, response times, etc.

## Demo: Thumbnails with Functions

> **Important Note**: the demo as designed will only work with files using the `.jpg` (not `.jpeg`, `.png` etc.) extension. This should be handled by the app but in case you are testing it manually, keep this in mind.

1. Take a picture in the app and save it
2. Navigate to the `wishlist` container in the storage account
3. Show the image and copy the full URL to the clipboard
4. Navigate to the `mod30-app` function and expand, drill into `MakeThumbnailHttp`
5. Open the "test" tab and change the body to:

    `{ "blob": "{url}" }`
6. Run and show the execution
7. Navigate back to the storage and show the thumbnail

## Demo: Trigger Function with Event Grid Event

1. Navigate to storage and show events
2. Navigate to the `mod30-app` function and expand, drill into `MakeThumbnailEventGrid`
3. Click "Add event grid subscription" and add the details of the storage account
4. Give it a name like "WishlistSubscription"
5. Topic Type is `Storage Accounts`
6. Select the `mod30demostorage` storage account
7. Filter to just the `Blob Created` event
8. Wait for subscription to confirm
9. Expand the logs and keep those open
10. Upload a new image and show it processed in the event grid
11. Navigate to storage and show the thumbnail

## Demo: Social Media Integration with Logic Apps

## Demo: Automatic Image Captioning with Cognitive Services

1. Navigate to the `mod30-caption` logic app
2. Walk through the various steps and explain how one step feeds into the next with variables
3. Show the functions integration and expand the functions code for `UpdateDescription`
4. Enable the logic app
5. Upload a new image and show the automated caption
