class Hero
  constructor:(@player, @socket, @model) ->
    @stats = @model.stats
    @health = @stats.health
    @strength = @stats.strength
    @mana = @stats.mana

  @FromModel: (player, socket, model) ->
    return new require('./heroes/'+model.type)(player, socket, model)

