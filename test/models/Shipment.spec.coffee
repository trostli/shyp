# Sails = require('sails')
sinon = require("sinon")
# assert = require("assert")
wolfpack = require("wolfpack")
s = require("../../api/models/Shipment")
console.log(s)

describe "The Shipment Model", ->

  Shipment = wolfpack(s)
  callback = sinon.stub()

  beforeEach ->
    wolfpack().clearResults()
    wolfpack().clearErrors()
    callback.reset()

  describe "#create()", ->
    it "should create without error", (done) ->
      Shipment.create({destinationAddress: "San Francisco, CA"}).done((err, shipment) ->
          assert.notEqual shipment, `undefined`
      )

  # describe "before the shipment is created", ->
  #   it "should geocode the address", (done) ->
  #     Shipment.beforeCreate
  #       destinationAddress: "San Francisco, CA"
  #     , (err, shipment) ->
  #         assert.equal shipment.destinationLatitude, "37.7749295"
  #         assert.equal shipment.destinationLongitude, "-122.4194155"
  #         done()
