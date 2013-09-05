mongo = require '../mongo'
jira = require '../jira/api'
User = require '../models/user'

exports.get = (req) ->
  return req.session.user

exports.loggedIn = (req) ->
  return req.session.user?

exports.redirectToLogin = (res) ->
  res.redirect '/user/login.html'

exports.init = (app) ->
  console.log 'Initializing user controller...'

  app.get '/user/logout', (req, res) ->
    req.session.username = null
    req.session.password = null
    req.session.user = null
    res.send 'Successfully logged out.'

  app.post '/user/login', (req, res) ->
    if req.session.user?
      res.redirect '/user/info'
    else
      req.session.username = req.body.username
      req.session.password = req.body.password
      User.FindOne req.session.username, (err, user) ->
        req.session.user = user
        if not req.session.user?
          jira.getUser req.session, (data) ->
            req.session.user = User.FromJira(JSON.parse(data))
            req.session.user.save ->
              res.redirect '/user/info'
        else
          res.redirect '/user/info'

  app.get '/user/info', (req, res) ->
    if req.session.user?
        res.send req.session.user
    else
      res.redirect '/user/login.html'
