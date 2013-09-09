userController = require './user'

exports.init = (app) ->
  app.get '/hero/:id', (req, res) ->
    user = userController.get(req)
    if not user?
      return userController.redirectToLogin res

    if not user.hasHero req.params.id
      res.send 'Invalid hero ID: '+req.params.id
    else
      res.send 'Looking at hero '+req.params.id

  console.log 'Initialized hero controller.'
