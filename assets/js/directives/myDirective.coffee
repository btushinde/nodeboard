app.directive 'myDirective', ['$log', ($log) ->
  restrict: 'EA'
  replace: true
  templateUrl: '/views/templates/common/myDirective.html'
  scope: {}
  controller: ['$scope', '$log', ($scope, $log) ->

  ]
  link: (scope, element, attrs) ->
]