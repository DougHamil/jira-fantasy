class Hero
  constructor:(@player, @socket, @model) ->

  @FromModel: (player, socket, model) ->
    return new require('./heroes/'+model.type)(player, socket, model)

