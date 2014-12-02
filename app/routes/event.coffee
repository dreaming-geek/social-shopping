handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/events'
    handler: handler.event.getEventAll

  server.route
    method: 'GET'
    path: '/api/events/{eventId}'
    handler: handler.event.getEvent

  server.route
    method: 'POST'
    path: '/api/events'
    handler: handler.event.createEvent

  server.route
    method: 'PUT'
    path: '/api/events/{eventId}'
    handler: handler.event.updateEvent

  server.route
    method: 'PUT'
    path: '/api/events/tag/{eventId}'
    handler: handler.event.updateEventTag

  server.route
    method: 'GET'
    path: '/api/events/rsvp/{eventId}'
    handler: handler.event.updateEventRsvp

  server.route
    method: 'DELETE'
    path: '/api/events/{eventId}'
    handler: handler.event.deleteEvent