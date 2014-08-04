/**
 * Shipment
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */
var geocoderProvider = 'google';
var httpAdapter = 'http';
var geocoder = require('node-geocoder').getGeocoder(geocoderProvider, httpAdapter);

module.exports = {

  attributes: {

    currentAddress: 'string',
    currentLatitude: 'float',
    currentLongitude: 'float',
  	destinationAddress: {
      type: 'string',
      required: true
    },
    destinationLatitude: 'float',
    destinationLongitude: 'float',
    packageLength: 'float',
    packageHeight: 'float',
    packageWidth: 'float',
    cost: 'integer'
  },

 beforeCreate: function(values, next) {
    if (!values.destinationLatitude || !values.destinationLongitude) {
      geocoder.geocode(values.destinationAddress, function(err, res) {
        values.destinationLatitude = res[0]["latitude"]
        values.destinationLongitude = res[0]["longitude"]
        next();
        if (err) {
          console.log("Error! " + err)
        }
      });
    } else {
        next();
    }
  }
};
