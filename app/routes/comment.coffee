handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/comments'
    handler: handler.comment.getCommentAll

  server.route
    method: 'GET'
    path: '/api/comments/{commentId}'
    handler: handler.comment.getComment

  server.route
    method: 'POST'
    path: '/api/comments'
    handler: handler.comment.createComment

  server.route
    method: 'PUT'
    path: '/api/comments/{commentId}'
    handler: handler.comment.updateComment

  server.route
    method: 'DELETE'
    path: '/api/comments/{commentId}'
    handler: handler.comment.deleteComment