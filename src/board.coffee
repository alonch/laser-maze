class Board
  constructor: (@size) ->
    @board = (false for i in [1..@size] for j in [1..@size])
    @players = []
  getSize: -> @size
  addPlayer: (player) -> @players.push(player)
  getPlayers: -> @players
  openBlocks:({start, end, line}) ->
    board = @board
    xAxis = (i, j) -> board[i][j] = true
    yAxis = (i, j) -> xAxis j, i
    update =  if line.axis is "x" then xAxis else yAxis
    update i, line.pos for i in [start .. end]
  isBlockOpen: (x, y)-> @board[x][y]
  getPlayer: (name) ->
    for player in @players
      if player.name is name
        return player

  movePlayer: (name, dir) ->
    speed = if dir in ["up", "right"] then 1 else -1
    player = @getPlayer(name)

    if dir in ["up", "down"]
      player.pos.y += speed
    else
      player.pos.x += speed


exports.Board = Board


