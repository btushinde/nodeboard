define [], ->
  app:
    defaultRoutePath: '/'
    routes:
      '/':
        templateUrl: '../../views/pages/dashboard/home.html'

      '/apps':
        templateUrl: '../../views/pages/apps/home.html'
        dependencies: [
          'controllers/appsController'
          'directives/myDirective'
        ]

      '/cli':
        templateUrl: '../../views/pages/terminal/home.html'
        dependencies: [
          'controllers/cliController'
          'services/browserDetectService'
          'terminal'
          'terminal/commService'
          'terminal/emulator'
          'terminal/webWorkerService'
          'terminal/workerAdaptor'
          'terminal/webSocketAdaptor'
          'terminal/remoteConnection'
          'terminal/appletService'
          'terminal/vt100'
          'terminal/terminalService'
          'terminal/terminalFactory'
          'directives/terminalUI'
        ]