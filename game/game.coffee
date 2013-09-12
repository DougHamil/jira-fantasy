class Game
  constructor: (@host) ->
    @players = []

  onHeroJoined: (player, hero) ->
    @players.push
      player:player
      hero: hero


module.exports = Game

