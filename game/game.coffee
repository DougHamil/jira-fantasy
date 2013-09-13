class Game
  constructor: (@host) ->
    @heroes = []
    @heroes.push(@host)

  onHeroJoined: (hero) ->
    @heroes.push(hero)

module.exports = Game
