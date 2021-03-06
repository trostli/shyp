module.exports = (req, res, next) ->

  # User is allowed, proceed to controller
  if req.session.me.role is "admin"
    next()

  # User is not allowed
  else
    res.send "You are not permitted to perform this action. You're just a #{req.session.me.role}", 403
