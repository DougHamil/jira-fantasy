exports.init = (server) ->
  Game = require('./game')
  Player = require('./player')

  io = require('socket.io').listen(server)

  gameById = {}
  playerToGameId = {}

  io.on 'connection', (socket) ->
    player = new Player(socket)

    socket.on 'create', () ->
      game = new Game(player)
      gameById[game.id] = game

    socket.on 'join', (gameId, heroId) ->
      playerToGameId[player] = gameId
      gameById[gameId].onHeroJoined(player, player.getHero(heroId))
