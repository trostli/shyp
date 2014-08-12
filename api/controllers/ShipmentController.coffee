module.exports =

  create: (req, res, next) ->
    params = req.params.all()
    userId = req.session.me.id
    Shipment.create
      destinationAddress: params["destinationAddress"]
      user: userId
      , (err, shipment) ->
        return next(err)  if err
        res.status 201
        res.json shipment
