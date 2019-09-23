# Using pre-built AI to understand images

In this demonstration, we will use Azure Computer Vision to detect the type of object
an image represents. 

First, we will use the Computer Vision online web-form to upload an image and observe the results.

Then, we will use the Computer Vision API to collect the same information programatically, using curl.

## Getting Set up

1. Download "CV Training Images.zip" to your local machine, and expand the zip file. This will create a folder "CV Training Images" with the following subfolders:
* drills
* hammers
* hard hats
* pliers
* screwdrivers

These images will be used to test the Computer Vision service and create a model with the Custom Vision service.

All images were sourced from Wikimedia Commons and used under their respective Creative Commons licenses. See the file [ATTRIBUTIONS.md](Attributions.md) for details.

# Demos

## Using Computer Vision via the Web interface

1. Visit the Computer Vision webpage at [https://azure.microsoft.com/en-us/services/cognitive-services/computer-vision/](https://azure.microsoft.com/en-us/services/cognitive-services/computer-vision/?WT.mc_id=msignitethetour2019-github-aiml20)

2. Scroll down to the "Analyze an Image" section. It looks like this:

!["Computer Vision: Analyze an Image"](img/Computer%20Vision%20%Analyze%20an%20Image.png)

3. Click the "Browse" button, and choose "Yellow Hard Hat.JPG" from the "hard hat" folder in "CV Training Images".

4. After a moment, the analysis of your image will appear in the right pane. It looks like this:

```
FEATURE NAME:	VALUE

Objects	[ { "rectangle": { "x": 893, "y": 483, "w": 2995, "h": 2167 }, "object": "headwear", "confidence": 0.676 } ]

Tags	[ { "name": "clothing", "confidence": 0.9981408 }, { "name": "headdress", "confidence": 0.9976504 }, { "name": "helmet", "confidence": 0.9865049 }, { "name": "indoor", "confidence": 0.9276736 }, { "name": "yellow", "confidence": 0.5328705 } ]

Description	{ "tags": [ "clothing", "headdress", "helmet", "indoor", "sitting", "yellow", "table", "small", "dark", "black", "white", "mirror", "sink", "room", "standing" ], "captions": [ { "text": "a yellow helmet on a table", "confidence": 0.465249538 } ] }

Image format	"Jpeg"

Image dimensions	2704 x 4064

Clip art type	1

Line drawing type	0

Black and white	false

Adult content	false

Adult score	0.00263372553

Racy	false

Racy score	0.00290701375

Categories	[ { "name": "abstract_shape", "score": 0.21875 }, { "name": "others_", "score": 0.046875 }, { "name": "outdoor_", "score": 0.03515625 } ]

Faces	[]

Dominant color background	"Black"

Dominant color foreground	"Yellow"

Accent Color	#956801
```

(Note, the above analysis may change in the future: the Computer Vision model is updated regularly.)

Note that in the first "Objects" result, one object is detected, and its location in the image is given. Its classified as "headwear", but for our application we'd like it classified as "hard hat". However "hard hat" is not one of the object types that Computer Vision currently detects. (We'll address this problem with Custom Vision, later.) Also note that a confidence score is given for the object classification.

The second "Tags" result gives a list of labels associated with the entire image. The tag with the highest confidence (listed first) is "clothing", which doesn't help us much. The third tag, "helmet", is better but still not exactly what we are looking for.

The other responses are also interesting, but we won't focus on them for our demo. But take a look at what's included:

* A caption for the photo ("a yellow helmet on a table") in the Description field.

* Image features (is it black and white? a line drawing?)

* Details of any faces detected in the image (none in this case)

* A score for the content of the image: is it "Adult" or "Racy"?

* Color analysis for the image: the dominant foreground, accent, and background colors.

We're really only interested in the "Tags" field for our purposes, so we'll find out how to extract that programatically in the next section.