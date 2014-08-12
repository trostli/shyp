# /**
#  * User
#  *
#  * @module      :: Model
#  * @description :: A short summary of how this model works and what it represents.
#  * @docs		:: http://sailsjs.org/#!documentation/models
#  */
bcrypt = require("bcrypt")

module.exports =
  schema: true

  attributes:
    email:
      type: "email"
      unique: true
      required: true
    name:
      type: "string"
      required: true
    password:
      type: "string"
      required: true
    role:
      type: "string"
      required: true
    shipments:
      collection: "Shipment"
      via: "user"

    # Override toJSON method to remove password from API
    toJSON: ->
      obj = this.toObject()
      delete obj.password
      return obj

  beforeCreate: (attrs, next) ->
    bcrypt.genSalt 10, (err, salt) ->
      return next(err)  if err
      bcrypt.hash attrs.password, salt, (err, hash) ->
        return next(err)  if err
        attrs.password = hash
        next()

  signup: (inputs, cb) ->
    User.create(
      name: inputs.name
      email: inputs.email
      password: inputs.password
      role: inputs.role
    ).exec cb

  attemptLogin: (inputs, cb) ->
    User.findOne(
      email: inputs.email
    ).exec cb
