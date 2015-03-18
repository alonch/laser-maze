describe 'LazerMaze', ->
  $document = null
  beforeEach ->
    module('laserMaze');

  describe "BoardController", ->
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
        it "valid key", ->#{37:'left', 38:'up', 39:'right', 40:'down'}
          for i in [37..40]
            expect($scope.keyPressed({which:i})).toBeTruthy()

        it "invalid key", ->
          for i in [0,25,100,234]
            expect($scope.keyPressed({which:i})).toBeFalsy()

    describe "$scope.board", ->
      it "exits", ->
        expect($scope.board).toBeTruthy()

      it "is not empty", ->
        expect($scope.board.length).toBeGreaterThan(0)

  describe "shortcutDirective", ->
    $compile = $rootScope = $document = null
    beforeEach inject (_$compile_, _$rootScope_, _$document_) ->
      $compile = _$compile_
      $rootScope = _$rootScope_
      $document = _$document_

    it 'is attached', ->
      spyOn($document, 'on')
      $compile("<div shortcut><div>") $rootScope
      expect($document.on).toHaveBeenCalledWith('keydown', jasmine.any(Function));

    it 'call keyPressed', ->
      $document.on = (type, fn) -> fn()
      $rootScope.keyPressed = ->
      spyOn($rootScope, 'keyPressed')
      $compile("<div shortcut><div>") $rootScope
      expect($rootScope.keyPressed).toHaveBeenCalled()


