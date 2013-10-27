define ['app', 'underscore'], (app)->

  terminal = angular.module('swtg.terminal', [])
    .config [
      '$controllerProvider'
      '$compileProvider'
      '$filterProvider'
      '$provide'
      ($controllerProvider, $compileProvider, $filterProvider, $provide) ->
        terminal.lazy =
          controller:  $controllerProvider.register
          directive:   $compileProvider.directive
          filter:      $filterProvider.register
          factory:     $provide.factory
          service:     $provide.service
    ]
  terminal
