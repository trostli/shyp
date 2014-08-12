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

  index: (req, res, next) ->
    user = req.session.me

    if user.role is "customer"
      Shipment.find()
      .where user: user.id
      .sort createdAt: 'desc'
      .exec (err, shipments) ->
        return next(err) if err
        res.status 201
        res.json shipments
    else
      Shipment.find()
      .sort createdAt: 'desc'
      .exec (err, shipments) ->
        return next(err) if err
        res.status 201
        res.json shipments

  # updatePackageSpec: (req, res, next) ->
  #   Shipment.create
  #     destinationAddress: params["destinationAddress"]
  #     user: userId
  #     , (err, shipment) ->
  #       return next(err)  if err
  #       res.status 201
  #       res.json shipment
