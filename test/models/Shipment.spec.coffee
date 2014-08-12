Shipment = require("../../api/models/Shipment")
sinon = require("sinon")
assert = require("assert")

describe "The Shipment Model", ->

  describe "before the shipment is created", ->
    it "should geocode the address", (done) ->

      Shipment.beforeCreate
        destinationAddress: "San Francisco, CA"
        destinationLatitude: null
        destinationLongitude: null

      , (err, shipment) ->
          assert.equal shipment.destinationLatitude, "37.7749295"
          assert.equal shipment.destinationLongitude, "-122.4194155"
          done()
