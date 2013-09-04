mongo = require '../mongo'
getCollection = () ->
  return mongo.db.collection 'users'

class User
  constructor: (jiraData) ->
    @name = jiraData.name
    @email = jiraData.emailAddress

  save: (cb) ->
    users = getCollection()
    users.insert @, (err, docs) ->
      if err
        throw err
      cb docs

  @FindOne: (name, cb) ->
    users = getCollection()
    return users.findOne {name: name}, cb

  @GetAll: (cb) ->
    users = getCollection()
    users.find().toArray cb

  @Exists: (name, cb) ->
    users = getCollection()
    users.find {name:name}, (err, item) ->
      if err or not item?
        cb(false)
      else
        cb(true)

module.exports = User

