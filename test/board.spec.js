// Generated by CoffeeScript 1.9.1
(function() {
  var module;

  module = {
    Board: require("../src/board")
  };

  describe("Board", function() {
    var board;
    board = 0;
    beforeEach(function() {
      return board = new module.Board(9);
    });
    it("construction", function() {
      return expect(board.getSize()).toBe(9);
    });
    return describe("blocks behaviors ", function() {
      describe("specified", function() {
        var block;
        block = 0;
        beforeEach(function() {
          return block = {
            start: 0,
            end: 6,
            line: {
              pos: 3
            }
          };
        });
        it("in X axis", function() {
          var open;
          block.line.axis = "x";
          board.openBlocks(block.line, block.start, block.end);
          open = board.isBlockOpen(6, 3);
          return expect(open).toBeTruthy();
        });
        return it("in Y axis", function() {
          var open;
          block.line.axis = "y";
          board.openBlocks(block.line, block.start, block.end);
          open = board.isBlockOpen(3, 6);
          return expect(open).toBeTruthy();
        });
      });
      return describe("defaults", function() {
        it("in X axis", function() {
          var line, open;
          board.openBlocks(line = {
            pos: 3,
            axis: "x"
          });
          open = board.isBlockOpen(6, 3);
          return expect(open).toBeTruthy();
        });
        return xit("in Y axis", function() {
          var line, open;
          board.openBlocks(line = {
            pos: 3,
            axis: "y"
          });
          open = board.isBlockOpen(3, 6);
          return expect(open).toBeTruthy();
        });
      });
    });
  });

}).call(this);
