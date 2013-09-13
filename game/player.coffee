Hero = require('./hero')

class Player
  constructor: (@user, @socket) ->
    # TODO: attach event listeners to socket events
  hasHero: (id) ->
    return @user.heroes[id]?
  getHero: (id) ->
    if id? and @hasHero(id)
      return Hero.FromModel(@, @socket, @getHeroModel(id))
    return null
  getHeroModel: (id) ->
    return @users.heroes[id]




