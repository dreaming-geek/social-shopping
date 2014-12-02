# Dependencies
Hapi = require 'hapi'
Good = require 'good'
Path = require 'path'
mongoose = require 'mongoose'
port = process.env.PORT or 3000

server = new Hapi.Server port,
  files:
    relativeTo: Path.join __dirname, 'public'

# Logging options
options =
  subscribers:
    'console': ['error','request']
    'logs/': ['log', 'error']

server.pack.register
  plugin: require 'good'
  options: options,
  (err) ->
    if err
      console.log err
      return

# MongoDB connection info
mongoose.connect 'MONGODB-URI'

# Models
models = require './models'

# Handlers
handler = require './handler'

# Routes
server.route
  method: 'GET'
  path: '/{filename*}'
  handler:
    directory:
      path: __dirname + '/public'
      listing: false
      index: false

routes = require './routes'
routes server

# Initialize server
server.start ->
  console.log "Server running on port #{port}"