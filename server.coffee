secret = 'JIRA_HERO_SECRET'
mongoose = require 'mongoose'
express = require 'express'
sessionStore = new express.session.MemoryStore()
cookieParser = express.cookieParser(secret)
jiraapi = require './lib/jira/api'
console.log 'here'
userController = require './lib/controllers/user'
heroController = require './lib/controllers/hero'
gameServer = require './game/server'

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

  # Init controllers
  userController.init app
  heroController.init app
  gameServer.init app.listen(3000), sessionStore, cookieParser
