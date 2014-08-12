User = require("../../api/models/User")
sinon = require("sinon")
assert = require("assert")

describe "The User Model", ->
  describe "before the user is created", ->
    it "should hash the password", (done) ->
      User.beforeCreate
        password: "password"
      , (err, user) ->
        assert.notEqual user.password, "password"
        done()
