module =
  Board: require "../src/board"
  Game: require "../src/game"

describe "Game", ->
  game = board = null
  beforeEach ->
    board = new module.Board 9
    game = new module.Game board

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

    it "throw exception if not fond", ->
      expect(-> game.getPlayer("")).toThrow(Error("Player not fond"))

    it "can be saved", ->
      game.addPlayer player
      players = game.getPlayers()
      expect(players[0]).toEqual player

    it "can move north", ->
      board.openBlocks line= pos:player.pos.x, axis:"y"
      game.addPlayer player
      game.movePlayer player.name, "up"
      expect(player.pos.y).toBe 4

    it "can move west", ->
      board.openBlocks line= pos:player.pos.y, axis:"x"
      game.addPlayer player
      game.movePlayer player.name, "left"
      expect(player.pos.x).toBe 2

    describe "sight", ->
      it "exits", ->
        game.addPlayer player
        expect(player.sight).toBeTruthy()

      it "correct size", ->
        game.addPlayer player
        expect(player.sight.length).toBe(board.getSize())

      it "maximum X", ->
        board.openBlocks line=pos:player.pos.x, axis:"y"
        game.addPlayer player
        for cell in player.sight[player.pos.x]
          expect(cell).toBeTruthy()

      it "maximum Y", ->
        board.openBlocks line=pos:player.pos.y, axis:"x"
        game.addPlayer player
        for i in [0..board.getSize()-1]
          cell = player.sight[i][player.pos.x]
          expect(cell).toBeTruthy()

      it "is restricted", ->
        board.openBlocks line=pos:3, axis:"y"
        board.openBlocks line=pos:player.pos.y, axis:"x"
        player.pos.x=0
        game.addPlayer player
        for i in [0..board.getSize()-1]
          cell = player.sight[3][i]
          if player.pos.y is i
            expect(cell).toBeTruthy()
          else
            expect(cell).toBeFalsy()

      it "is restricted with wall", ->
        board.openBlocks line=pos:player.pos.x, axis:"y", start=4
        board.openBlocks line=pos:player.pos.x, axis:"y", start=0, end=1
        board.openBlocks line=pos:player.pos.y, axis:"x"
        game.addPlayer player
        for i in [0..board.getSize()-1]
          cell = player.sight[player.pos.x][i]
          if player.pos.y <= i
            expect(cell).toBeTruthy()
          else
            expect(cell).toBeFalsy()


