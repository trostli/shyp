# /**
#  * User
#  *
#  * @module      :: Model
#  * @description :: A short summary of how this model works and what it represents.
#  * @docs		:: http://sailsjs.org/#!documentation/models
#  */

User =
  schema: true

  attributes:
    username:
      type: "string"
      unique: true
      required: true
    email:
      type: "string"
      unique: true
    passports:
      collection: 'Passport'
      via: 'user'
    admin:
      type: "boolean"
      default: false
    tech:
      type: "boolean"
      default: false
    driver:
      type: "boolean"
      default: false
    # shipments:
    #   collection: "Shipment"
    # Override toJSON method to remove password from API
    toJSON: ->
      obj = this.toObject()
      delete obj.password
      return obj

  beforeCreate: (attrs, next) ->
    bcrypt = require("bcrypt")
    bcrypt.genSalt 10, (err, salt) ->
      return next(err)  if err
      bcrypt.hash attrs.password, salt, (err, hash) ->
        return next(err)  if err
        attrs.password = hash
        next()

module.exports = User
