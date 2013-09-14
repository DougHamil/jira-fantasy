mongoose = require 'mongoose'
Schema   = mongoose.Schema

schema = new Schema
  name:
    type: String
    default: 'Unnamed'
  heroType:
    type: String
    default: 'mage'
  stats:
    strength: Number
    mana: Number
    stealth: Number

Hero = mongoose.model('Hero', schema)
module.exports = Hero
