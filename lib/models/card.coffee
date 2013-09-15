mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

schema = new Schema
  title: String
  description: String
  health: Number
  cost: Number    # Cost to play this card
  damage: Number
  specials: [     #Special abilities of this card
    type: String  #Type of special ability
    data: String  #Any additional meta-data required for the ability, should be JSON
  ]

Card = mongoose.model('Card', schema)
module.exports = Card
