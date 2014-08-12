# /**
#  * Shipment
#  *
#  * @module      :: Model
#  * @description :: A short summary of how this model works and what it represents.
#  * @docs		:: http://sailsjs.org/#!documentation/models
#  */

geocoderProvider = 'google'
httpAdapter = 'http'
geocoder = require('node-geocoder').getGeocoder(geocoderProvider, httpAdapter)

module.exports =
  attributes:
    currentAddress: "string"
    currentLatitude: "float"
    currentLongitude: "float"
    destinationAddress:
      type: "string"
      required: true

    destinationLatitude: "float"
    destinationLongitude: "float"
    packageLength: "float"
    packageHeight: "float"
    packageWidth: "float"
    cost: "integer"
    user:
      model: 'User'

  beforeCreate: (values, next) ->
    if not values.destinationLatitude or not values.destinationLongitude
      geocoder.geocode values.destinationAddress, (err, res) ->
        if err
          next(err)
        else
          values.destinationLatitude = res[0]["latitude"]
          values.destinationLongitude = res[0]["longitude"]
          next(null, values)
    else
      next(null, values)
