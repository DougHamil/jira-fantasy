exports.init = (app) ->
  app.get '/', (req, res) ->
    res.render 'index', { user: req.session.user?.name}
