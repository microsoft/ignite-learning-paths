# Personalizer Demo

In this demo, observe how the layout of a website adapts to visitor actions using reinforcement learning and [Cognitive Services Personalizer](https://docs.microsoft.com/en-us/azure/cognitive-services/personalizer/?WT.mc_id=msignitethetour2019-github-aiml20).

Personalizer will dynamically reconfigure the interface to optimize the
likelihood of an anonymous visitor clicking on the featured category in the
Recommended section.

1. Deploy the Tailwind Traders Website app

2. Visit the Tailwind Traders homepage

3. Observe the "Recommended" section and the order of the featured categories

4. Refresh the page (you may need to do this a couple of times). Observe that
   the layout changes.

The Personaizer service is tracking the anonymous visitors and recording the
time of day, day of week, and browser OS used when clicking on categories. 
The "reward" is whether or not the large, featured section was clicked. 

Over time, Personalizer will determine the best category to feature based on
time of day, day of week, and OS. It will also "explore" 20% of the time, to
surface categories that would otherwise not be presented.