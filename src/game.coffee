class Game
  constructor: (@board) ->
    @players = []

  addPlayer: (player) ->
    @players.push(player)
    player.sight = @board.generateSight(player.pos)

  getPlayers: -> @players

  getPlayer: (name) ->
    for player in @players
      if player.name is name
        return player
    throw new Error("Player not fond")

  movePlayer: (name, dir) ->
    speed = if dir in ["up", "right"] then 1 else -1
    player = @getPlayer(name)
    if dir in ["up", "down"]
      player.pos.y += speed
    else
      player.pos.x += speed

module.exports = Game