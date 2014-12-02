handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/likes'
    handler: handler.like.getLikeAll

  server.route
    method: 'GET'
    path: '/api/likes/{likeId}'
    handler: handler.like.getLike

  server.route
    method: 'POST'
    path: '/api/likes'
    handler: handler.like.createLike

  server.route
    method: 'PUT'
    path: '/api/likes/{likeId}'
    handler: handler.like.updateLike

  server.route
    method: 'DELETE'
    path: '/api/likes/{likeId}'
    handler: handler.like.deleteLike

