mongo = require '../../mongo'

collection = () ->
  return mongo.db.collection 'heroes'

class Hero
  constructor: ->
    @type = 'none'
    @name = '<Unnamed>'

  @FromJson: (json) ->
    if typeof json is 'string'
      json = JSON.parse(json)
    HeroClass = require json.type
    return new HeroClass(json)

  @FindOne: (id, cb) ->
    heroes = collection()
    heroes.findone id, cb
    return

module.exports = Hero
