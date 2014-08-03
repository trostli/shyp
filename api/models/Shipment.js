/**
 * Shipment
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {

  attributes: {

    currentAddress: 'string',
    currentLatitude: 'float',
    currentLongitude: 'float',
  	destinationAddress: {
      type: 'string',
      required: true
    }
    destinationLatitude: 'float',
    destinationLongitude: 'float',
    packageLength: 'float',
    packageHeight: 'float',
    packageWidth: 'float',
    cost: 'integer'

  }

};
