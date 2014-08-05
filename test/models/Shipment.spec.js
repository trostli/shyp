var Shipment = require('../../api/models/Shipment'),
    sinon = require('sinon'),
    assert = require('assert');

// var wolfpack = require('wolfpack');
// // We put in the global scope our instantiated model to be used by the controller
// var Model = wolfpack('../../api/models/Shipment');

// Set results for a create operation
// wolfpack().setCreateResults({id:1, name:'John Doe'});

describe('The Shipment Model', function() {

  describe('#save()', function(){
    it('should save without error', function(done){
      Shipment.create({destinationAddress: 'San Francisco, CA'}, function(err, shipment) {
      assert.notEqual(shipment, undefined);
      done();
    });
    })
  })

  describe('before the shipment is created', function () {
      it ('should geocode the address', function (done) {
          Shipment.beforeCreate({
              destinationAddress: 'San Francisco, CA'
          }, function (err, shipment) {
              assert.equal(shipment.destinationLatitude, '37.7749295');
              assert.equal(shipment.destinationLongitude, '-122.4194155');
              done();
          });
      });
  });
});
