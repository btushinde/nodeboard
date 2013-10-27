require.config
  basePath: './'
  paths:
    dependencyResolver: 'util/dependencyResolver'
  shim:
    'angular':
      'exports': 'angular'
      'deps': ['jquery']
    'angular-route': ['angular']
    'angular-cookies': ['angular']
    'bootstrap': ['jquery']
    'underscore':
      'exports': '_'
  priority: ['angular']

require ['app'], (app) ->
  angular.element(document).ready ->
    angular.bootstrap(document, ['apollo'])

