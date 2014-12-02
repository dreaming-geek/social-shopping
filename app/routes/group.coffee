handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/groups'
    handler: handler.group.getGroupsAll

  server.route
    method: 'GET'
    path: '/api/groups/{groupId}'
    handler: handler.group.getGroup

  server.route
    method: 'POST'
    path: '/api/groups'
    handler: handler.group.createGroup

  server.route
    method: 'PUT'
    path: '/api/groups/{groupId}'
    handler: handler.group.updateGroup

  server.route
    method: 'PUT'
    path: '/api/groups/member/{groupId}'
    handler: handler.group.deleteGroupMember

  server.route
    method: 'DELETE'
    path: '/api/groups/{groupId}'
    handler: handler.group.deleteGroup
