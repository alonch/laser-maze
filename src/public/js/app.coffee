app = angular.module 'laserMaze', []
app.controller 'boardController', ($scope) ->
  $scope.player =
    name:'alonso'
    pos:x:4, y:5
    move: (dir) ->
      speed = if dir in ["up", "left"] then -1 else 1
      if dir in ["up", "down"]
        @pos.y += speed
      else if dir in ["left", "right"]
        @pos.x += speed
      else
        throw new Error("Invalid move")
  $scope.board = (true for i in [1..9] for j in [1..9])
  $scope.board[$scope.player.pos.y][$scope.player.pos.x] = $scope.player
  $scope.keyPressed = (e) ->
    if 40 < e.which || e.which < 37
      return false
    numberToText = {37:'left', 38:'up', 39:'right', 40:'down'}
    $scope.board[$scope.player.pos.y][$scope.player.pos.x] = true
    $scope.player.move(numberToText[e.which])
    $scope.board[$scope.player.pos.y][$scope.player.pos.x] = $scope.player
    return true

app.directive 'shortcut', ($document)->
  instance =
    restrict: 'A'
    replace: true
    scope: true
    link: (scope, iElement, iAttrs) ->
      $document.on 'keydown', (e) ->
        scope.$apply(scope.keyPressed(e))
