handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/roles'
    handler: handler.role.getRolesAll

  server.route
    method: 'GET'
    path: '/api/roles/{roleId}'
    handler: handler.role.getRole

  server.route
    method: 'POST'
    path: '/api/roles'
    handler: handler.role.createRole

  server.route
    method: 'PUT'
    path: '/api/roles/{roleId}'
    handler: handler.role.updateRole

  server.route
    method: 'DELETE'
    path: '/api/roles/{roleId}'
    handler: handler.role.deleteRole