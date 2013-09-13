mongoose = require 'mongoose'
Schema = mongoose.Schema
String = Schema.String

schema = new Schema
  name:
    type: String
    default: 'Unnamed'
  heroType:
    type: String
    default: 'mage'
  stats:
    strength: Number,
    magic: Number,
    stealth: Number

Hero = mongoose.model('Hero', schema)
module.exports = Hero
