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
    console.log 'Attempting to log user in: '+req.body.username
    req.session.username = req.body.username
    req.session.password = req.body.password

    redir = if req.session.redir? then req.session.redir else '/'
    console.log "Redirect query param: "+req.session.redir

    # Attempt to find the user by username
    User.findOne {name: req.session.username}, (err, user) ->
      req.session.user = user

      # If user doesn't exist, then get the user details from JIRA
      if not req.session.user?
        console.log "#{req.session.username} is a new user, asking about him from JIRA..."
        jira.getUser req.session, (data) ->
          console.log "Received user data from JIRA: #{data.name}"
          #TODO: Check for invalid user login for JIRA and return error
          req.session.user = new User({name: data.name, email: data.emailAddress})
          req.session.user.save (err) ->
            if err?
              console.log "Error saving user: "+err
            else
              res.redirect redir
      else
        console.log 'Welcome back, '+user.name
        res.redirect redir

  app.get '/user/info', (req, res) ->
    if req.session.user?
        res.send req.session.user
    else
      res.redirect '/user/login.html'

  console.log 'Initialized user controller.'
