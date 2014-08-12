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

  update: (req, res, next) ->
    user = req.session.me
    params = req.params.all()
    id = req.param('id')
    if user.role is "driver"
      Shipment.update(
        id
        currentLatitude: params["currentLatitude"], currentLongitude: params["currentLongitude"]
        , (err, shipment) ->
          return next(err) if err
          res.status 201
          res.json shipment
      )

    else if user.role is "tech"
      Shipment.update(
        id
        packageLength: params["packageLength"]
        , packageHeight: params["packageHeight"]
        , packageWidth: params["packageWidth"]
        , packageWeight: params["packageWeight"]
        , (err, shipment) ->
          return next(err) if err
          res.status 201
          res.json shipment
      )
    else if user.rolf is "admin"
      Shipment.update(
        id
        params
        , (err, shipment) ->
          return next(err) if err
          res.status 201
          res.json shipment
      )
