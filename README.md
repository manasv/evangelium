[![Netlify Status](https://api.netlify.com/api/v1/badges/36ba5654-56c5-47c8-91fc-ad07609975e6/deploy-status)](https://app.netlify.com/sites/evangelium/deploys)
# Evangelium API - Daily Gospel at your fingertips
Read-Only API to get the daily gospel in 7 different languages, [Check Repo](https://github.com/manasv/evangelium).

## Deployment
The deployment of the API is on [Netlify](https://www.netlify.com/)  and the build file is `/Sources/SwiftyEvangelium/main.swift`.

## Endpoints
The endpoints return data in json format:

First date available: 2019-09-13

- Readings per day : `https://evangelium.manuelsanchez.dev/api/:language/days/:date`

Example : (Date format: YYYY-MM-DD)
- https://evangelium.manuelsanchez.dev/api/es/days/2019-09-15
```json
{
  "date": "2019-09-15",
  "first_reading": {
    "type": "reading",
    "reference_displayed": "Example Reference",
    "text": "Example Text",
    "title": "Example Title"
  },
  "psalm": {
    "type": "psalm",
    "reference_displayed": "Example Reference",
    "text": "Example Text",
    "title": "Example Title"
  },
  "second_reading": {
    "type": "reading",
    "reference_displayed": "Example Reference.",
    "text": "Example Text",
    "title": "Example Title"
  },
  "gospel": {
    "type": "gospel",
    "reference_displayed": "Example Reference",
    "text": "Example Text",
    "title": "Example Title"
  }
}  
```

## Supported Languages

*   [es] Spanish 
*   [en] English 
*   [it] Italian 
*   [fr] French  
*   [pt] Portuguese 
*   [kr] Korean  
*   [de] German  

## Credits

For the guide and idea to host read only api on netlify: [@AntoineAugusti](https://github.com/AntoineAugusti)

## Licence
MIT
