// Generated by CoffeeScript 1.9.1
(function() {
  var Board, Game;

  Game = (function() {
    function Game(size) {
      this.board = new Board(size);
      this.players = [];
    }

    Game.prototype.getSize = function() {
      return this.board.size;
    };

    Game.prototype.addPlayer = function(player) {
      this.players.push(player);
      return player.sight = this.board.generateSight(player.pos);
    };

    Game.prototype.getPlayers = function() {
      return this.players;
    };

    Game.prototype.openBlocks = function(line, start, end) {
      var board, i, k, ref, ref1, results, update, xAxis, yAxis;
      if (start == null) {
        start = 0;
      }
      if (end == null) {
        end = this.getSize() - 1;
      }
      board = this.board.maze;
      xAxis = function(i, j) {
        return board[i][j] = true;
      };
      yAxis = function(i, j) {
        return xAxis(j, i);
      };
      update = line.axis === "x" ? xAxis : yAxis;
      results = [];
      for (i = k = ref = start, ref1 = end; ref <= ref1 ? k <= ref1 : k >= ref1; i = ref <= ref1 ? ++k : --k) {
        results.push(update(i, line.pos));
      }
      return results;
    };

    Game.prototype.isBlockOpen = function(x, y) {
      return this.board.maze[x][y];
    };

    Game.prototype.getPlayer = function(name) {
      var k, len, player, ref;
      ref = this.players;
      for (k = 0, len = ref.length; k < len; k++) {
        player = ref[k];
        if (player.name === name) {
          return player;
        }
      }
    };

    Game.prototype.movePlayer = function(name, dir) {
      var player, speed;
      speed = dir === "up" || dir === "right" ? 1 : -1;
      player = this.getPlayer(name);
      if (dir === "up" || dir === "down") {
        return player.pos.y += speed;
      } else {
        return player.pos.x += speed;
      }
    };

    return Game;

  })();

  Board = (function() {
    function Board(size1) {
      this.size = size1;
      this.maze = this.generateBoard();
    }

    Board.prototype.generateBoard = function() {
      var i, j, k, ref, results;
      results = [];
      for (j = k = 1, ref = this.size; 1 <= ref ? k <= ref : k >= ref; j = 1 <= ref ? ++k : --k) {
        results.push((function() {
          var l, ref1, results1;
          results1 = [];
          for (i = l = 1, ref1 = this.size; 1 <= ref1 ? l <= ref1 : l >= ref1; i = 1 <= ref1 ? ++l : --l) {
            results1.push(false);
          }
          return results1;
        }).call(this));
      }
      return results;
    };

    Board.prototype.generateSight = function(arg) {
      var maze, processDirection, processFor, sight, size, x, y;
      x = arg.x, y = arg.y;
      sight = this.generateBoard();
      maze = this.maze;
      size = this.size - 1;
      processDirection = function(start, set, get) {
        processFor(start, size, set, get);
        return processFor(start, 0, set, get);
      };
      processFor = function(start, end, set, get) {
        var i, k, ref, ref1;
        for (i = k = ref = start, ref1 = end; ref <= ref1 ? k <= ref1 : k >= ref1; i = ref <= ref1 ? ++k : --k) {
          if (!get(i)) {
            return;
          }
          set(i, get(i));
        }
      };
      processDirection(x, function(i, value) {
        return sight[i][y] = value;
      }, function(i) {
        return maze[i][y];
      });
      processDirection(y, function(i, value) {
        return sight[x][i] = value;
      }, function(i) {
        return maze[x][i];
      });
      return sight;
    };

    return Board;

  })();

  exports.Game = Game;

}).call(this);
