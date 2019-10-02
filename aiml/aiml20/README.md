# Using Pre-Built AI to Solve Business Challenges

This is the repository supporting the Ignite Tour 2019-2020 talk, "Using
Pre-Built AI to Solve Business Challenges". Here you will find links to the
resources mentioned in the talk, and the code and scripts you will need to
recreate the demos given in the talk.

## Talk Summary

As a data-driven company, Tailwind Traders understands the importance of using
Artificial Intelligence to improve business processes and delight customers.
Before investing in an AI team, their existing developers were able to
demonstrate some quick wins using pre-built AI technologies. In this session, we
will show how you can use Azure Cognitive Services to extract insights from
retail data and go into the neural networks behind computer vision. You’ll learn
how it works and how to augment the pre-built AI with your own images for custom
image recognition applications.

## Technologies used

* [Azure Cognitive Services](https://docs.microsoft.com/en-us/azure/cognitive-services/?WT.mc_id=msignitethetour2019-github-aiml20)
* [Azure Cloud Shell](https://docs.microsoft.com/en-us/azure/cloud-shell/overview?WT.mc_id=msignitethetour2019-github-aiml20)
* [Azure Command Line Interface (CLI)](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest?WT.mc_id=msignitethetour2019-github-aiml20)
* [ONNX](https://github.com/onnx/onnx)
* [Visual Studio Code]()

## Other resources mentioned in talk

* How Neural Networks Work, by Brandon Rohrer: http://brohrer.github.io/blog.html
* XKCD "Tasks": https://xkcd.com/1425

### Azure Cognitive Services docs and app

* Cognitive Services Computer Vision: [https://aka.ms/try-computervision](https://azure.microsoft.com/en-us/services/cognitive-services/computer-vision/?WT.mc_id=ignitetour-talk-davidsmi)  
* Cognitive Services Custom Vision: [Documentation](https://docs.microsoft.com/en-us/azure/cognitive-services/custom-vision-service/?WT.mc_id=ignitethetour-github-davidsmi) and application at [https://customvision.ai](https://www.customvision.ai/?WT.mc_id=ignitethetour-github-davidsmi)
* ONNX Runtime: https://github.com/microsoft/onnxruntime
* Cognitive Services Personalizer: [https://aka.ms/personalizer-intro](https://docs.microsoft.com/en-us/azure/cognitive-services/personalizer/?WT.mc_id=msignitethetour2019-github-aiml20)
* Reinforcement Learning with Personalizer: https://aka.ms/personalizerdemo
* Cognitive Services in containers: https://aka.ms/cs-containers

### Cognitive Services information

* Cognitve Services pricing: https://aka.ms/cs-pricing 
* Cognitive Services compliance and privacy: https://aka.ms/az-compliance
* Microsoft's approach to ethical AI: [https://microsoft.com/AI/our-approach-to-ai](https://www.microsoft.com/AI/our-approach-to-ai?rtc=1&WT.mc_id=msignitethetour2019-github-aiml20)
* Cognitive Services training courses in Microsoft Learn: https://aka.ms/AIML20MSLearnCollection
* Microsoft Certified Azure Data Scientist Associate: https://aka.ms/DataScientistCert 
* Microsoft Certified Azure AI Engineer Associate https://aka.ms/AIEngineerCert

## Demonstrations

Follow the links below for details on how to recreate the demos given in the
talk. You will need an Azure Subscription to run these demos; if you don't have
one yet, here is a link for [$200 Free Azure Credits for new
subscribers](https://aka.ms/azure-free-credits).

1. [Setup](DEMO%20Setup.md): Create accounts and deploy and configure resources
   to support the demos below. Follow these instructions before attempting any
   of the demos below.

1. [Computer Vision](DEMO%20Computer%20Vision.md): Use Cognitive Services
   Computer Vision to analyze an image, via a web application and via the Azure
   CLI.

1. [Custom Vision](DEMO%20Custom%20Vision.md): Create a custom vision model to
   detect only products sold by Tailwind Traders.

1. [ONNX Deployment](DEMO%20ONNX%20deployment.md): Deploy a custom vision model in
   the ONNX format to the Tailwind Traders website "Shop by Photo feature

1. [Personalizer](DEMO%20Personalizer.md): Dynamically reconfigure the layout of
   the "Recommended" section of the Tailwind Traders website, to optimize
   likelihood of an anonymous visitor clicking on the "featured" product.

# Feedback Loop

Do you have a comment, feedback, suggestion? Currently, the best feedback loop for content changes/suggestions/feedback is to create a new issue on this GitHub repository. To get all the details about how to create an issue please refer to the [Contributing docs](https://github.com/microsoft/ignite-learning-paths/blob/master/contributing.md)