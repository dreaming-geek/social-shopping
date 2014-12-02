handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/users'
    handler: handler.users.getUsers

  server.route
    method: 'GET'
    path: '/api/users/{userId}'
    handler: handler.users.getUser

  server.route
    method: 'PUT'
    path: '/api/users/{userId}'
    handler: handler.users.updateUser

  server.route
    method: 'POST'
    path: '/api/users'
    handler: handler.users.createUser

  server.route
    method: 'DELETE'
    path: '/api/users/{userId}'
    handler: handler.users.deleteUser

  server.route
    method: 'PUT'
    path: '/api/users/address/{userId}'
    handler: handler.users.updateUserAddress

  server.route
    method: 'PUT'
    path: '/api/users/phone/{userId}'
    handler: handler.users.updateUserPhone


