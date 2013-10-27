
app.controller 'dashboardCtrl', [
  '$log'
  '$scope'
  'emulator'
  'terminalService'
  ($log, $scope, emulator, ts) ->

    # cs = comm.connect({})
    # $log.log cs

    # console.log emulator, comm
    $scope.terminals = ts.getRegistry()

    $scope.$on '$destroy', ->
      $log.info 'CLI Conroller destroyed'

    $scope.sendMsg = ->
      # ts.sendMsg $scope.activeTerm, $scope.userInput

    $scope.selectTerm = (id) ->
      # $scope.activeTerm = ts.setActiveTerm(id)
]
