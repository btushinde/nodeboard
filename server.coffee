require 'coffee-script'
app = require './server/index'
port = app.port

app.listen port, ->
  console.log 'Listening on ' + port + '\nPress CTRL-C to stop server.'
