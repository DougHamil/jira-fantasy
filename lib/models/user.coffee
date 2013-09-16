mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

schema = new Schema
  name: String
  email: String
  lastLogin: String
  heroes: [{id:ObjectId}]
  decks: [ObjectId]             # Links to this user's deck library
  lastLoginIssueKeys: [String]
  points:
    type: Number                # Number of points to spend
    default: 0

User = mongoose.model('User', schema)
module.exports = User
