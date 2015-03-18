// Generated by CoffeeScript 1.9.1
(function() {
  var module;

  module = {
    Board: require("../src/board"),
    Game: require("../src/game")
  };

  describe("Game", function() {
    var board, game;
    game = board = null;
    beforeEach(function() {
      board = new module.Board(9);
      return game = new module.Game(board);
    });
    return describe("player", function() {
      var player;
      player = 0;
      beforeEach(function() {
        return player = {
          pos: {
            x: 3,
            y: 3
          },
          name: 'alonso'
        };
      });
      it("is save", function() {
        var players;
        game.addPlayer(player);
        players = game.getPlayers();
        return expect(players.length).toBe(1);
      });
      it("is accessed by name", function() {
        var savedPlayer;
        game.addPlayer(player);
        savedPlayer = game.getPlayer(player.name);
        return expect(savedPlayer).toEqual(player);
      });
      it("throw exception if not fond", function() {
        return expect(function() {
          return game.getPlayer("");
        }).toThrow(Error("Player not fond"));
      });
      it("can be saved", function() {
        var players;
        game.addPlayer(player);
        players = game.getPlayers();
        return expect(players[0]).toEqual(player);
      });
      it("can move north", function() {
        var line;
        board.openBlocks(line = {
          pos: player.pos.x,
          axis: "y"
        });
        game.addPlayer(player);
        game.movePlayer(player.name, "up");
        return expect(player.pos.y).toBe(4);
      });
      it("can move west", function() {
        var line;
        board.openBlocks(line = {
          pos: player.pos.y,
          axis: "x"
        });
        game.addPlayer(player);
        game.movePlayer(player.name, "left");
        return expect(player.pos.x).toBe(2);
      });
      return describe("sight", function() {
        it("exits", function() {
          game.addPlayer(player);
          return expect(player.sight).toBeTruthy();
        });
        it("correct size", function() {
          game.addPlayer(player);
          return expect(player.sight.length).toBe(board.getSize());
        });
        it("maximum X", function() {
          var cell, j, len, line, ref, results;
          board.openBlocks(line = {
            pos: player.pos.x,
            axis: "y"
          });
          game.addPlayer(player);
          ref = player.sight[player.pos.x];
          results = [];
          for (j = 0, len = ref.length; j < len; j++) {
            cell = ref[j];
            results.push(expect(cell).toBeTruthy());
          }
          return results;
        });
        it("maximum Y", function() {
          var cell, i, j, line, ref, results;
          board.openBlocks(line = {
            pos: player.pos.y,
            axis: "x"
          });
          game.addPlayer(player);
          results = [];
          for (i = j = 0, ref = board.getSize() - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
            cell = player.sight[i][player.pos.x];
            results.push(expect(cell).toBeTruthy());
          }
          return results;
        });
        it("is restricted", function() {
          var cell, i, j, line, ref, results;
          board.openBlocks(line = {
            pos: 3,
            axis: "y"
          });
          board.openBlocks(line = {
            pos: player.pos.y,
            axis: "x"
          });
          player.pos.x = 0;
          game.addPlayer(player);
          results = [];
          for (i = j = 0, ref = board.getSize() - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
            cell = player.sight[3][i];
            if (player.pos.y === i) {
              results.push(expect(cell).toBeTruthy());
            } else {
              results.push(expect(cell).toBeFalsy());
            }
          }
          return results;
        });
        return it("is restricted with wall", function() {
          var cell, end, i, j, line, ref, results, start;
          board.openBlocks(line = {
            pos: player.pos.x,
            axis: "y"
          }, start = 4);
          board.openBlocks(line = {
            pos: player.pos.x,
            axis: "y"
          }, start = 0, end = 1);
          board.openBlocks(line = {
            pos: player.pos.y,
            axis: "x"
          });
          game.addPlayer(player);
          results = [];
          for (i = j = 0, ref = board.getSize() - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
            cell = player.sight[player.pos.x][i];
            if (player.pos.y <= i) {
              results.push(expect(cell).toBeTruthy());
            } else {
              results.push(expect(cell).toBeFalsy());
            }
          }
          return results;
        });
      });
    });
  });

}).call(this);
