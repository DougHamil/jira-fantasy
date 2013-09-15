mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

schema = new Schema
  name: String
  data: String

Ability = mongoose.model('Ability', schema)
module.exports = Ability
