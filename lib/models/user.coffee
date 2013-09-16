mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

schema = new Schema
  name: String
  email: String
  lastLogin: String
  lastLoginPoints: {type:Number, default:0}
  lastLoginIssueKeys: [String]
  heroes: [{type:ObjectId, ref:'Hero'}]
  decks: [ObjectId]             # Links to this user's deck library
  points: {type:Number, default:0}

User = mongoose.model('User', schema)
module.exports = User
