// Generated by CoffeeScript 1.9.1
(function() {
  var Board;

  Board = (function() {
    function Board(size1) {
      this.size = size1;
      this.board = this.generateBoard();
      this.players = [];
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

    Board.prototype.getSize = function() {
      return this.size;
    };

    Board.prototype.addPlayer = function(player) {
      this.players.push(player);
      return player.sight = this.generateSight(player.pos);
    };

    Board.prototype.generateSight = function(arg) {
      var board, processDirection, processFor, sight, size, x, y;
      x = arg.x, y = arg.y;
      sight = this.generateBoard();
      board = this.board;
      size = this.getSize() - 1;
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
        return board[i][y];
      });
      processDirection(y, function(i, value) {
        return sight[x][i] = value;
      }, function(i) {
        return board[x][i];
      });
      return sight;
    };

    Board.prototype.getPlayers = function() {
      return this.players;
    };

    Board.prototype.openBlocks = function(line, start, end) {
      var board, i, k, ref, ref1, results, update, xAxis, yAxis;
      if (start == null) {
        start = 0;
      }
      if (end == null) {
        end = this.getSize() - 1;
      }
      board = this.board;
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

    Board.prototype.isBlockOpen = function(x, y) {
      return this.board[x][y];
    };

    Board.prototype.getPlayer = function(name) {
      var k, len, player, ref;
      ref = this.players;
      for (k = 0, len = ref.length; k < len; k++) {
        player = ref[k];
        if (player.name === name) {
          return player;
        }
      }
    };

    Board.prototype.movePlayer = function(name, dir) {
      var player, speed;
      speed = dir === "up" || dir === "right" ? 1 : -1;
      player = this.getPlayer(name);
      if (dir === "up" || dir === "down") {
        return player.pos.y += speed;
      } else {
        return player.pos.x += speed;
      }
    };

    return Board;

  })();

  exports.Board = Board;

}).call(this);
