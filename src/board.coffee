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
    board = @board
    size = @getSize()-1

    processDirection = (start, set, get) ->
      processFor start, size, set, get
      processFor start, 0, set, get

    processFor = (start, end, set, get) ->
      for i in [start..end]
        if not get(i)
          return
        set i, get(i)

    processDirection x,
      (i, value) -> sight[i][y] = value,
      (i) -> board[i][y]

    processDirection y,
      (i, value) -> sight[x][i] = value,
      (i) -> board[x][i]

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


