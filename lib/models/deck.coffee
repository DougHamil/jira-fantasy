mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

schema = new Schema
  name: String
  cards: [ObjectId]  #Links to all of the cards in this deck

Deck = mongoose.model('Deck', schema)
module.exports = Deck
