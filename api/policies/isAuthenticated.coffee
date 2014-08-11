# /**
#  * isAuthenticated
#  *
#  * @module      :: Policy
#  * @description :: Simple policy to allow any authenticated user
#  *                 Assumes that your login action in one of your controllers sets `req.session.authenticated = true;`
#  * @docs        :: http://sailsjs.org/#!documentation/policies
#  *
#  */
module.exports = (req, res, next) ->

  # If `req.session.me` exists, that means the user is logged in.
  return next()  if req.session.me

  # If this is not an HTML-wanting browser, e.g. AJAX/sockets/cURL/etc.,
  # send a 401 response letting the user agent know they need to login to
  # access this endpoint.
  return res.send(401)  if req.wantsJSON

  # Otherwise if this is an HTML-wanting browser, do a redirect.
  res.redirect "/login"
