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
  movePlayer: (name, dir) ->
    speed = if dir in ["up", "right"] then 1 else -1
    player = @getPlayer(name)
    if dir in ["up", "down"]
      player.pos.y += speed
    else
      player.pos.x += speed
  getSize: -> @board.getSize()
  openBlocks:(line, start, end) -> @board.openBlocks(line, start, end)
  isBlockOpen: (x, y)-> @board.isBlockOpen(x, y)

class Board
  constructor:(@size) ->
    @maze = @generateBoard()

  generateBoard: ->
    (false for i in [1..@size] for j in [1..@size])

  generateSight: ({x, y}) ->
    sight = @generateBoard()
    maze = @maze
    size = @size-1

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
      (i) -> maze[i][y]

    processDirection y,
      (i, value) -> sight[x][i] = value,
      (i) -> maze[x][i]

    return sight
  getSize: -> @size
  openBlocks:(line, start=0, end=@getSize()-1) ->
    maze = @maze
    xAxis = (i, j) -> maze[i][j] = true
    yAxis = (i, j) -> xAxis j, i
    update =  if line.axis is "x" then xAxis else yAxis
    update i, line.pos for i in [start .. end]
  isBlockOpen: (x, y)-> @maze[x][y]

exports.Game = Game
exports.Board = Board


