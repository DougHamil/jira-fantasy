jira = require '../jira/api'
User = require '../models/user'

exports.get = (session) ->
  return session.user

exports.loggedIn = (session) ->
  return session.user?

exports.redirectToLogin = (res) ->
  res.redirect '/user/login.html'

exports.init = (app) ->
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

      # Attempt to find the user by username
      User.find {name: req.session.username}, (err, users) ->
        if not users or users.length <= 0
          req.session.user = null
        else
          req.session.user = users[0]

        # If user doesn't exist, then get the user details from JIRA
        if not req.session.user?
          jira.getUser req.session, (data) ->
            #TODO: Check for invalid user login for JIRA and return error
            req.session.user = new User({name: data.name, email: data.emailAddress})
            req.session.user.save ->
              res.redirect '/user/info'
        else
          res.redirect '/user/info'

  app.get '/user/info', (req, res) ->
    if req.session.user?
        res.send req.session.user
    else
      res.redirect '/user/login.html'

  console.log 'Initialized user controller.'
