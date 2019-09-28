# POST-INCIDENT REVIEW

**Incident Name:** Incident-19
**Date:** 10/13/19
**Severity:** 3

## GOALS
1. Learn more about our socio-technical system. 
2. Detect incidents more quickly.
3. Respond and remediate incidents more smoothly and rapidly.
4. Discover action items that might improve our system or knowledge. 

## CUSTOMER IMPACT
* Were customers impacted?
* If so, were they contacted?
* What follow-up is needed?
* Do you need to notify any customers of collateral damage resulting from this incident? 
* How can you reduce the number of customers impacted if a similar incident occurs? 

## DETAILS
* What was the to acknowledge? _How long was the issue occurring before an incident response was initiated?)_
* What was the time to recover? _How long did it take to restore service?_ 

## PEOPLE
* Incident Commander (IC):
* First-Responder (if different from IC):
* Communications Chief or Scribe: 
* Who else helped?

## ATTEMPTED WORK
* What initial actions did you take in response to this incident? 
* Which tasks had a positive impact?
* Which tasks had a negative impact?
* Which tasks had a neutral impact?

## CHAT LOGS
* Where are the chat transcripts of the incident channel accessible?
* Where are the recordings of video calls accessible?

## ACTIVITY
* Include a visual timeline below, if applicable.

## CONTRIBUTING FACTORS
* List the factors within the socio-technical system that contributed to this particular incident. 

## ACTION ITEMS
* What changes to monitoring, alerting, logging, and dashboards would help notify you about this particular problem faster in the future? 
* What automated tests should you add to ensure that this particular incident won’t occur again? 

## MOVING FORWARD
* Is the service stable moving forward? 
* Does someone need to write additional documentation? 
* Did the incident impact any data? If data was lost, can you restore it? 
* Did the incident impact any data? If data was lost, can you restore it? 
* Is any additional follow up needed?

## SUMMARY

Ultimately, there was no process in place to check the configuration management settings and confirm connection strings 
pointed to the appropriate environment. This left room for engineers to make mistakes and point production to the development 
or staging environments. Knowing this, tests have been put in place along the CI/CD pipeline to confirm the correct 
environment is listed and firewall rules were updated to check as well. 

