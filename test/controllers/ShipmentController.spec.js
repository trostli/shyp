var ShipmentController = require('../../api/controllers/ShipmentController'),
    sinon = require('sinon'),
    assert = require('assert');

describe('The Shipment Controller', function() {
  describe('when we invoke the index action', function() {
    it('should return an array of shipments', function() {

      // Mocking res.send() method by using a sinon spy
      var send = sinon.spy();

      // Executes controller action
      ShipmentController.index(null, {
        'send': send
      });

      // Asserts send() method was called and that it was called
      // with the correct arguments: 'Hello World'
      assert(send.called);
`    });
  });
});
