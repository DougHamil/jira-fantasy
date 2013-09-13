mongoose       = require 'mongoose'
express        = require 'express'
jiraapi        = require './lib/jira/api'
userController = require './lib/controllers/user'
heroController = require './lib/controllers/hero'
gameServer     = require './game/server'

secret       = 'JIRA_HERO_SECRET'
sessionStore = new express.session.MemoryStore()
cookieParser = express.cookieParser(secret)

mongoose.connect('mongodb://localhost:27017/test')

db = mongoose.connection
db.on('error', console.error.bind(console, 'connection error:'))
db.once 'open', ->
  # Init web server
  app = express()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.session({store:sessionStore, secret: secret, key:'express.sid'})
  app.use express.static('public')

  app.all '/api/*', (req, res, next) ->
    console.log req.path
    if req.path != '/api/user/login'
      if not req.session.user?
        console.log "API request attempt for invalid user"
        res.redirect '/user/info'
      else
        req.user = req.session.user
        next()
    else
      console.log 'Login request'
      next()

  # Init controllers
  userController.init app
  heroController.init app
  gameServer.init app.listen(3000), sessionStore, cookieParser
