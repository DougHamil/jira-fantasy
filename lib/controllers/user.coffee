mongo = require '../mongo'
jira = require '../jira/api'
User = require '../models/user'

exports.init = (app) ->
  app.get '/user/logout', (req, res) ->
    req.session.username = null
    req.session.password = null
    req.session.user = null
    res.send 'Successfully logged out.'

  app.post '/user/login', (req, res) ->
    req.session.username = req.body.username
    req.session.password = req.body.password
    User.FindOne req.session.username, (err, user) ->
      req.session.user = user
      if not req.session.user?
        console.log 'Request user from JIRA'
        jira.getUser req.session, (data) ->
          req.session.user = new User(JSON.parse(data))
          console.log 'Received JIRA user info'
          console.log req.session.user
          res.redirect '/user/info'
      else
        console.log "User data already stored in mongo"
        res.redirect '/user/info'

  app.get '/user/info', (req, res) ->
    if req.session.user?
        res.send req.session.user
    else
      res.redirect '/user/login.html'
