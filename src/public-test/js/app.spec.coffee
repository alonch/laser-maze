describe 'boardController', ->
  beforeEach ->
    module('laserMaze');
  $scope = controller = null

  beforeEach inject (_$controller_) ->
    $scope = {};
    controller = _$controller_('boardController', { $scope: $scope })

  describe '$scope.player', ->
    it "exits", ->
      expect($scope.player).toBeTruthy()

    it "has position", ->
      expect($scope.player.pos).toBeTruthy()

    it "has name", ->
      expect($scope.player.name).toBeTruthy()
    describe "can move", ->
      y = x = null
      beforeEach ->
        y = $scope.player.pos.y
        x = $scope.player.pos.x

      it "up", ->
        $scope.player.move("up")
        expect($scope.player.pos.y).toBe(y-1)

      it "left", ->
        $scope.player.move("left")
        expect($scope.player.pos.x).toBe(x-1)

      it "down", ->
        $scope.player.move("down")
        expect($scope.player.pos.y).toBe(y+1)

      it "left", ->
        $scope.player.move("right")
        expect($scope.player.pos.x).toBe(x+1)

      it "invalid", ->
        expect(-> $scope.player.move("nothing")).toThrow()

    describe "capture", ->
      it "arrow up", ->#{37:'left', 38:'up', 39:'right', 40:'down'}
        $scope.keyPressed()

  describe "$scope.board", ->
    it "exits", ->
      expect($scope.board).toBeTruthy()

    it "is not empty", ->
      expect($scope.board.length).toBeGreaterThan(0)

