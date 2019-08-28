# MOD30: Enhancing Web Applications with Cloud Intelligence

Tailwind Traders has implemented development frameworks, deployment strategies, and server infrastructure for their apps. But now that they are on the cloud it’s time to extend functionality by tapping into powerful services that automatically scale and run exactly where and when they need them. This includes image resizing, messaging, integration with social media and tapping into cloud intelligence for image identification.

In this session, we’ll create a set of routines that run on Azure Functions, respond to events in Azure Event Grid, and integrate cloud services with Azure Logic Apps. We’ll also use Azure Cognitive Services to add AI capabilities and Xamarin for a mobile app.

## Demo Setup

1. Provision the Tailwind Traders monolith app available [here](https://gist.github.com/anthonychu/9ab34d2991fb5c1c0c29faeebbe43a51)
2. Install [Node.js](https://nodejs.org) LTS
3. Install [artillery](https://artillery.io/): `npm i -g artillery`

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

1. Take a picture in the app and save it
2. Navigate to the `wishlist` container in the storage account
3. Show the image and save the full URL
4. Navigate to the `mod30-app` function and expand, drill into `MakeThumbnailHttp`
5. Open the "test" tab and change the body to:

    `{ "blob": "{url}" }`
6. Run and show the execution
7. Navigate back to the storage and show the thumbnail

## Demo: Trigger Function with Event Grid Event

1. Navigate to storage and show events
2. Navigate to the `mod30-app` function and expand, drill into `MakeThumbnailEventGrid`
3. Click "Add event grid subscription" and add the details of the storage account
4. Filter to just the "blob created" event
5. Wait for subscription to confirm
6. Expand the logs
7. Upload a new image and show it processed in the event grid
8. Navigate to storage and show the thumbnail

## Demo: Social Media Integration with Logic Apps

## Demo: Automatic Image Captioning with Cognitive Services
