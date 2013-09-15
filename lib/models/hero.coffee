mongoose = require 'mongoose'
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId

schema = new Schema
  name:                   #Name of this player's hero
    type: String
    default: 'Unnamed'
  class: ObjectId         #Link to HeroClass
  level: Number           #Hero's current level
  xp: Number              #Hero's current xp
  abilities: [ObjectId]   #Hero's current available powers (unlocked with levels)
  decks: [ObjectId]       #Links to this hero's owned decks (up to 3)

Hero = mongoose.model('Hero', schema)
module.exports = Hero
