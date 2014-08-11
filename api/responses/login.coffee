bcrypt = require('bcrypt')

module.exports = login = (inputs) ->
  inputs = inputs or {}

  # Get access to `req` and `res`
  req = @req
  res = @res

  # Look up the user
  User.attemptLogin
    email: inputs.email
  , (err, user) ->
    return res.negotiate(err)  if err
    unless user
      # If this is not an HTML-wanting browser, e.g. AJAX/sockets/cURL/etc.,
      # send a 200 response letting the user agent know the login was successful.
      # (also do this if no `invalidRedirect` was provided)
      return res.badRequest("Invalid username.")  if req.wantsJSON or not inputs.invalidRedirect

      # Otherwise if this is an HTML-wanting browser, redirect to /login.
      return res.redirect(inputs.invalidRedirect)

    bcrypt.compare(inputs.password, user.password, (err, match) ->
      if err
        return res.badRequest("DB error")  if req.wantsJSON or not inputs.invalidRedirect
        return res.redirect(inputs.invalidRedirect)
      else if match
        # "Remember" the user in the session
        req.session.me = user.id
        return res.ok()  if req.wantsJSON or not inputs.successRedirect
        res.redirect inputs.successRedirect
      else
        return res.badRequest("Invalid username/password combination.")  if req.wantsJSON or not inputs.invalidRedirect
        return res.redirect(inputs.invalidRedirect)
    )

