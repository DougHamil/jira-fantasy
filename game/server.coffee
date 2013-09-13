UserController = require '../lib/controllers/user'

exports.init = (server, sessionStore, cookieParser) ->
  Hero = require('./hero')
  Game = require('./game')
  Player = require('./player')
  SessionSockets = require('session.socket.io')

  io = require('socket.io').listen(server)
  sessionio = new SessionSockets(io, sessionStore, cookieParser)

  gameById = {}
  playerToGameId = {}

  sessionio.on 'connection', (err, socket, session) ->
    # Make sure connecting user is logged in
    if err? or not UserController.loggedIn(session)
      return

    player = new Player(session.user, socket)

    socket.on 'host', (heroId) ->
      game = new Game(player)
      gameById[game.id] = game

    socket.on 'join', (gameId, heroId) ->
      if not player.hasHero heroId
        return

      playerToGameId[player] = gameId
      gameById[gameId].onHeroJoined(player.getHero(heroId))
