mongoose = require 'mongoose'
Schema   = mongoose.Schema
ObjectId = Schema.ObjectId

schema = new Schema
  name:                   #Name of this player's hero
    type: String
    default: 'Unnamed'
  class: {type:ObjectId, ref:'HeroClass'}   #Link to HeroClass
  level: {type:Number, default:0}           #Hero's current level
  xp: {type:Number, default:0}              #Hero's current xp
  abilities: [{type:ObjectId, ref:'Ability'}]                     #Hero's current available powers (unlocked with levels)
  decks: [{type:ObjectId, ref:'Deck'}]                         #Links to this hero's owned decks (up to 3)

Hero = mongoose.model('Hero', schema)
module.exports = Hero
