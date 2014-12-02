handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/personas'
    handler: handler.persona.getPersonaAll

  server.route
    method: 'GET'
    path: '/api/personas/{personaId}'
    handler: handler.persona.getPersona

  server.route
    method: 'POST'
    path: '/api/personas'
    handler: handler.persona.createPersona

  server.route
    method: 'PUT'
    path: '/api/personas/{personaId}'
    handler: handler.persona.updatePersona

  server.route
    method: 'DELETE'
    path: '/api/personas/{personaId}'
    handler: handler.persona.deletePersona