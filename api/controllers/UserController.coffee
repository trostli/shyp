
# UserController

# @module    :: Controller
# @description :: Contains logic for handling requests.

module.exports =

  login: (req, res) ->

    # See `api/responses/login.js`
    res.login
      email: req.param("email")
      password: req.param("password")
      successRedirect: "/"
      invalidRedirect: "/login"

  logout: (req, res) ->

    # "Forget" the user from the session.
    # Subsequent requests from this user agent will NOT have `req.session.me`.
    req.session.me = null

    # If this is not an HTML-wanting browser, e.g. AJAX/sockets/cURL/etc.,
    # send a simple response letting the user agent know they were logged out
    # successfully.
    return res.ok("Logged out successfully!")  if req.wantsJSON

    # Otherwise if this is an HTML-wanting browser, do a redirect.
    res.redirect "/"

  signup: (req, res) ->

    # Attempt to signup a user using the provided parameters
    User.signup
      name: req.param("name")
      email: req.param("email")
      password: req.param("password")
    , (err, user) ->

      # res.negotiate() will determine if this is a validation error
      # or some kind of unexpected server error, then call `res.badRequest()`
      # or `res.serverError()` accordingly.
      return res.negotiate(err)  if err

      # Go ahead and log this user in as well.
      # We do this by "remembering" the user in the session.
      # Subsequent requests from this user agent will have `req.session.me` set.
      req.session.me = user.id

      # If this is not an HTML-wanting browser, e.g. AJAX/sockets/cURL/etc.,
      # send a 200 response letting the user agent know the signup was successful.
      return res.ok("Signup successful!")  if req.wantsJSON

      # Otherwise if this is an HTML-wanting browser, redirect to /welcome.
      res.redirect "/welcome"

