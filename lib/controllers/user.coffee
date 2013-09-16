Jira = require '../jira/api'
User = require '../models/user'
ModelHelper = require '../models/helper'

exports.getUserModel = (user, cb) ->
  User.findOne {_id:user._id}, (err, userModel) ->
    cb userModel

exports.get = (session) ->
  return session.user

exports.loggedIn = (session) ->
  return session.user?

onUserLoggedIn = (req, res, username, password, user) ->
  redir = if req.session.redir? then req.session.redir else '/'
  delete req.session.redir
  req.session.user = user
  currentTime = Jira.getDateTime()
  lastLogin = user.lastLogin ? currentTime
  lastLoginIssueKeys = user.lastLoginIssueKeys ? []
  Jira.getTotalStoryPointsSince lastLogin, lastLoginIssueKeys, username, password, (err, points, keys) ->
    if not err?
      user.points += points
      user.lastLoginIssueKeys = keys
      user.lastLogin = currentTime
      console.log "User #{user.name} has earned #{points} points since last logging on #{lastLogin}"
      user.save (err) ->
        if err?
          console.log 'Error saving user '+user.name
          console.log err
    else
      console.log 'Error getting user story points: '+username
      console.log err
      console.log points
    res.redirect redir

exports.init = (app) ->
  app.post '/user/login', (req, res) ->
    username = req.body.username
    password = req.body.password

    # Use JIRA to authenticate the login first
    Jira.getUser username, password, (err, jiraData) ->
      if not err?
        # Attempt to find the user by username
        User.findOne {name:jiraData.name}, (err, user) ->
          req.session.user = user
          if not user?
            console.log "#{jiraData.name} is a new user, building new user from JIRA data..."
            if jiraData.name?
              user = new User({name: jiraData.name, email: jiraData.emailAddress, lastLogin:Jira.getDateTime()})
              user.save (err) ->
                if err?
                  console.log "Error saving user: "+err
                else
                  onUserLoggedIn(req, res, username, password, user)
          else
            onUserLoggedIn(req, res, username, password, user)
      else
        req.session.loginFailed = true
        # Unable to login to JIRA, redirect to login
        res.redirect '/login'

  app.get '/user/logout', (req, res) ->
    req.session.user = null
    res.send 'Successfully logged out.'

  app.get '/user/info', (req, res) ->
    if req.session.user?
      User.findOne {_id:req.session.user._id}, (err, user) ->
        ModelHelper.deepPopulate user, 'heroes heroes.class decks', {}, ->
          res.send user
    else
      res.redirect '/login'

  console.log 'Initialized user controller.'
