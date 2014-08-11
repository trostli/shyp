module.exports = (req, res, next) ->

  # User is allowed, proceed to controller
  if req.session.user && req.session.user.tech
    next()

  # User is not allowed
  else
    res.send "You are not permitted to perform this action.", 403
