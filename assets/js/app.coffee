
app = angular.module('warboard', ['ngRoute', 'ngCookies'])
  .config ['$routeProvider', '$locationProvider', ($routeProvider, $locationProvider) ->
      $locationProvider.html5Mode true
  ]



angular.element(document).ready -> angular.bootstrap(document, ['warboard'])

