mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

schema = new Schema
  name: String
  media:
    img: String       # path to image for this hero class
    taunts: [String]  # paths to taunt audios
  abilities: [
    level: Number
    id: ObjectId
  ]

HeroClass = mongoose.model('HeroModel', schema)
module.exports = HeroClass
