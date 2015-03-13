board = require "../src/board"

describe "board", ->
  player = 0
  game = 0
  blockToOpen = 0
  beforeEach ->
    blockToOpen =
      x:
        start:6
        end:0
        line:
          pos:3
          axis:"x"
      y:
        start:6
        end:0
        line:
          pos:3
          axis:"y"

    game = new board.Board 9
    player =
      pos: {x:3,y:3},
      name:'alonso'
    game.addPlayer(player)

  it "create a board 9x9", ->
    expect(game.getSize()).toBe 9

  it "can save player", ->
    players = game.getPlayers()
    expect(players.length).toBe 1

  it "get the correct player by name", ->
    savedPlayer = game.getPlayer(player.name)
    expect(savedPlayer).toEqual player

  it "player is saved correctly", ->
    players = game.getPlayers()
    expect(players[0]).toEqual player

  it "board open X blocks ", ->
    game.openBlocks blockToOpen.x
    open = game.isBlockOpen(6,3)
    expect(open).toBeTruthy()

  it "board open Y blocks ", ->
    game.openBlocks blockToOpen.y
    open = game.isBlockOpen(3,6)
    expect(open).toBeTruthy()

  it "player can move north", ->
    game.openBlocks blockToOpen.x
    game.movePlayer player.name, "up"
    expect(player.pos.y).toBe 4

  it "player can move west", ->
    game.openBlocks blockToOpen.y
    game.movePlayer player.name, "left"
    expect(player.pos.x).toBe 2
