Hero = require '../hero'
class Mage extends Hero
  constructor: (player, socket, model) ->
    super
    console.log 'Constructed mage'
    console.log @player
  @GetMetaData: ->
    return {
      hats: ['wizard']
    }

module.exports = Mage

