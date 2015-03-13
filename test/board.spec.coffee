module =
  Board: require "../src/board"

describe "Board", ->
  board = 0
  beforeEach ->
    board = new module.Board 9

  it "construction", ->
    expect(board.getSize()).toBe 9

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
        board.openBlocks block.line, block.start, block.end
        open = board.isBlockOpen(6,3)
        expect(open).toBeTruthy()

      it "in Y axis", ->
        block.line.axis="y"
        board.openBlocks block.line, block.start, block.end
        open = board.isBlockOpen(3,6)
        expect(open).toBeTruthy()

    describe "defaults", ->
      it "in X axis", ->
        board.openBlocks line= pos:3,axis:"x"
        open = board.isBlockOpen(6,3)
        expect(open).toBeTruthy()

      xit "in Y axis", ->
        board.openBlocks line= pos:3, axis:"y"
        open = board.isBlockOpen(3,6)
        expect(open).toBeTruthy()

