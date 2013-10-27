express = require 'express'
stylus = require 'stylus'
mongoose = require 'mongoose'


#### Basic application initialization
# Create app instance.
app = express()

# Define Port
app.port = process.env.PORT or process.env.VMC_APP_PORT or 3000

# Config module exports has `setEnvironment` function that sets app settings depending on environment.
config = require "./config"
app.configure 'production', 'development', 'testing', ->
  config.setEnvironment app.settings.env

# db_config = "mongodb://#{config.DB_USER}:#{config.DB_PASS}@#{config.DB_HOST}:#{config.DB_PORT}/#{config.DB_NAME}"
# mongoose.connect db_config
if app.settings.env != 'production'
  mongoose.connect 'mongodb://localhost/example'
  app.locals.pretty = true
else
  console.log('If you are running in production, you may want to modify the mongoose connect path')



#### View initialization

# Set folder for static assets
app.use express.static(process.cwd() + '/public')

# Set View Engine.
app.set 'view engine', 'jade'

# Rails-like asset pipeline
app.use require('connect-assets')()

# [Body parser middleware](http://www.senchalabs.org/connect/middleware-bodyParser.html) parses JSON or XML bodies into `req.body` object
app.use express.bodyParser()


#### Finalization
# Initialize routes
routes = require './routes'
routes(app)

# Export application object
module.exports = app

