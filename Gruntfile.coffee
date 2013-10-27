module.exports = (grunt) ->
  # Grab all grunt-* packages from package.json and load their tasks
  require('matchdep').filterDev('grunt-*').forEach grunt.loadNpmTasks

  grunt.initConfig
    # Load packages
    pkg: grunt.file.readJSON 'package.json'

    # Watch and compile app whenever changes are made
    # Enable LiveReload server for faster development
    watch:
      options:
        livereload: true
      jade:
        files: 'views/**/*.jade'
      'server-coffee':
        files: 'server/**/*.coffee'
        tasks: ['coffeelint:server']
      'app-coffee':
        files: 'assets/**/*.coffee'
        tasks: ['coffeelint:app']
      gruntfile:
        files: 'Gruntfile.coffee'
        tasks: ['coffeelint:gruntfile']

    # Debugging with node-inspector
    'node-inspector':
      default: {}

    # Reload dev server on source code change
    nodemon:
      dev:
        options:
          file: 'server.coffee'
          watchedExtensions: ['coffee']
          watchedFolders: ['server']
          delayTime: 0
      debug:
        options:
          file: 'server.coffee'
          nodeArgs: ['--debug']
          watchedExtensions: ['coffee']
          watchedFolders: ['server']
          delayTime: 0

    # Notification via Growl/OSX
    notify_hooks:
      options:
        enabled: true
        max_jshint_notifications: 5

    # Documentation generation based on comments
    groc:
      javascript: ['server/**/*.coffee']
      options:
        out: 'doc/'

    # Run shell commands directly
    shell:
      options:
        stdout: true
      server:
        command: 'coffee server.coffee'
      test:
        command: 'mocha --require should --compilers coffee:coffee-script --colors'


    # CoffeeLint for helpful feedback
    coffeelint:
      app: ['assets/**/*.coffee']
      server: ['server/**/*.coffee']
      gruntfile: 'Gruntfile.coffee'
      options:
        max_line_length:
          value: 160
          level: 'warn'
        no_throwing_strings:
          level: 'warn'


  #################
  # TASKS
  #################

    # Run tasks concurrently
    concurrent:
      dev: ['nodemon:dev', 'watch', 'notify_hooks']
      debug: ['nodemon:debug', 'node-inspector', 'watch', 'debug-pages', 'notify_hooks']
      options:
        logConcurrentOutput: true


  # Register tasks
  grunt.registerTask  'build',     ['coffeelint']
  grunt.registerTask  'dev',       ['build', 'concurrent:dev']
  grunt.registerTask  'debug',     ['concurrent:debug']
  grunt.registerTask  'default',   ['dev']



  # Delay opening browser until server is ready
  grunt.registerTask  'debug-pages', 'opens up browser pages for debug mode', ->
    done = this.async()
    setTimeout (->
      grunt.task.run 'open:inspector'
      done()
      ), 1000


