exports.init = (app) ->
  app.get '/', (req, res) ->
    if req.session.user?
      res.render 'index', { user: req.session.user}
    else
      res.redirect '/login'
  app.get '/login', (req, res) ->
    data =
      failed: req.session.loginFailed?
    delete req.session.loginFailed
    res.render 'login', data
