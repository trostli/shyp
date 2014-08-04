/**
 * Shipment
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */
var geocoderProvider = 'google';
var httpAdapter = 'http';
// optional
// var extra = {
//     apiKey: 'AIzaSyBo_tsvoKmNgXKvSDVuhRBOLsaeEdGh0L8', // for map quest
//     formatter: null         // 'gpx', 'string', ...
// };

var geocoder = require('node-geocoder').getGeocoder(geocoderProvider, httpAdapter);

// Using callback
geocoder.geocode('Fornino, 187 Bedford Ave, Brooklyn, NY 11211', function(err, res) {
    console.log(res);
});

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
