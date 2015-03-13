class Board
  constructor: (@size) ->
    @board = @generateBoard()
    @players = []
  generateBoard: -> (false for i in [1..@size] for j in [1..@size])
  getSize: -> @size
  addPlayer: (player) ->
    @players.push(player)
    player.sight = @generateSight(player.pos)
  generateSight: ({x, y}) ->
    sight = @generateBoard()
    len = Math.max(x, @getSize()-x, y, @getSize()-y)
    for i in [x..@getSize()-1]
      if not @board[i][y]
        break
      sight[i][y] = @board[i][y]
    for i in [y..@getSize()-1]
      if not @board[x][i]
        break
      sight[x][i] = @board[x][i]
    for i in [x..0]
      if not @board[i][y]
        break
      sight[i][y] = @board[i][y]
    for i in [x..0]
      if not @board[x][i]
        break
      sight[x][i] = @board[x][i]
    return sight
  getPlayers: -> @players
  openBlocks:(line, start=0, end=@getSize()-1) ->
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


