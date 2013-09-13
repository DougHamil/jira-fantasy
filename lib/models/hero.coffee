mongo = require '../../mongo'

collection = () ->
  return mongo.db.collection 'heroes'

class Hero
  constructor: (@type, @name)->

  @FindOne: (id, cb) ->
    heroes = collection()
    heroes.findone id, cb
    return

module.exports = Hero
