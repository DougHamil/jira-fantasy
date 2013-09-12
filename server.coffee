express = require 'express'
mongo = require './lib/mongo'
jiraapi = require './lib/jira/api'
userController = require './lib/controllers/user'
heroController = require './lib/controllers/hero'
gameServer = require './game/server'

app = express()
app.use express.bodyParser()
app.use express.cookieParser()
app.use express.session({secret: 'JIRA_HEROES_SESSION'})
app.use express.static('public')

# Init controllers after mongo connection has been initialized
mongo.init ->
  userController.init app
  heroController.init app
  gameServer.init app.listen(3000)
