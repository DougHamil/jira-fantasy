mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

schema = new Schema
  name: String
  email: String
  heroes: [{id:ObjectId}]

User = mongoose.model('User', schema)
module.exports = User
