board = require "../src/board"

describe "board ", ->
  game = 0
  beforeEach ->
    game = new board.Game 9

  it "construction", ->
    expect(game.getSize()).toBe 9

  describe "player", ->
    player = 0
    beforeEach ->
      player =
        pos:
          x:3
          y:3
        name:'alonso'

    it "is save", ->
      game.addPlayer player
      players = game.getPlayers()
      expect(players.length).toBe 1

    it "is accessed by name", ->
      game.addPlayer player
      savedPlayer = game.getPlayer(player.name)
      expect(savedPlayer).toEqual player

    it "can be saved", ->
      game.addPlayer player
      players = game.getPlayers()
      expect(players[0]).toEqual player

    it "can move north", ->
      game.openBlocks line= pos:3, axis:"y"
      game.addPlayer player
      game.movePlayer player.name, "up"
      expect(player.pos.y).toBe 4

    it "can move west", ->
      game.openBlocks line= pos:3, axis:"x"
      game.addPlayer player
      game.movePlayer player.name, "left"
      expect(player.pos.x).toBe 2

    describe "sight", ->
      it "exits", ->
        game.addPlayer player
        expect(player.sight).toBeTruthy()

      it "correct size", ->
        game.addPlayer player
        expect(player.sight.length).toBe(game.getSize())

      it "maximum X", ->
        game.openBlocks line=pos:player.pos.x, axis:"y"
        game.addPlayer player
        for cell in player.sight[player.pos.x]
          expect(cell).toBeTruthy()

      it "maximum Y", ->
        game.openBlocks line=pos:player.pos.y, axis:"x"
        game.addPlayer player
        for i in [0..game.getSize()-1]
          cell = player.sight[i][player.pos.x]
          expect(cell).toBeTruthy()

      it "is restricted", ->
        game.openBlocks line=pos:3, axis:"y"
        game.openBlocks line=pos:player.pos.y, axis:"x"
        player.pos.x=0
        game.addPlayer player
        for i in [0..game.getSize()-1]
          cell = player.sight[3][i]
          if player.pos.y is i
            expect(cell).toBeTruthy()
          else
            expect(cell).toBeFalsy()

      it "is restricted with wall", ->

        game.openBlocks line=pos:player.pos.x, axis:"y", start=4
        game.openBlocks line=pos:player.pos.x, axis:"y", start=0, end=1
        game.openBlocks line=pos:player.pos.y, axis:"x"
        game.addPlayer player
        for i in [0..game.getSize()-1]
          cell = player.sight[player.pos.x][i]
          if player.pos.y <= i
            expect(cell).toBeTruthy()
          else
            expect(cell).toBeFalsy()

  describe "blocks behaviors ", ->
    describe "specified", ->
      block = 0
      beforeEach ->
        block =
          start:0
          end:6
          line:
            pos:3

      it "in X axis", ->
        block.line.axis="x"
        game.openBlocks block.line, block.start, block.end
        open = game.isBlockOpen(6,3)
        expect(open).toBeTruthy()

      it "in Y axis", ->
        block.line.axis="y"
        game.openBlocks block.line, block.start, block.end
        open = game.isBlockOpen(3,6)
        expect(open).toBeTruthy()

    describe "defaults", ->
      it "in X axis", ->
        game.openBlocks line= pos:3,axis:"x"
        open = game.isBlockOpen(6,3)
        expect(open).toBeTruthy()

      xit "in Y axis", ->
        game.openBlocks line= pos:3, axis:"y"
        open = game.isBlockOpen(3,6)
        expect(open).toBeTruthy()



