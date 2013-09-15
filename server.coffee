mongoose       = require 'mongoose'
express        = require 'express'
jiraapi        = require './lib/jira/api'
userController = require './lib/controllers/user'
heroController = require './lib/controllers/hero'
viewsController= require './lib/controllers/views'
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
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
#
# Init controllers
  userController.init app

  app.all '/api/*', (req, res, next) ->
    console.log 'API request: '+req.path
    if not req.session.user?
      console.log "User is not logged in, redirecting to login."
      req.session.redir = req.path
      res.redirect '/user/login.html'
    else
      req.user = req.session.user
      next()
#
  heroController.init app
  viewsController.init app

  gameServer.init app.listen(3000), sessionStore, cookieParser
