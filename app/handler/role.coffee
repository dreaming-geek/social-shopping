models = require '../models'
Role = models.Role

module.exports =
  getRolesAll: (request, reply) ->
    Role.find (err, roles) ->
      if err
        reply "There was an error with the request."
        console.log "Error: #{err}"
      reply roles: roles

  getRole: (request, reply) ->
    roleId = encodeURI request.params.roleId
    Role.findById roleId, (err, role) ->
      if err
        reply "Could not find the role. Please try again."
        console.log "Error #{err}"
      reply role: role

  createRole: (request, reply) ->
    rp = request.payload
    newRole = new Role()
    newRole.name = rp.name
    newRole.save (err) ->
      if err
        reply "Could not save the role. Please try again."
        console.log "Error: #{err}"
      reply role: newRole

  updateRole: (request, reply) ->
    rp = request.payload
    roleId = encodeURI request.params.roleId
    Role.findById roleId, (err, role) ->
      if err
        reply "Could not find the role. Please try again."
        console.log "Error: #{err}"
      else
        role.deleted = rp.deleted or role.deleted
        role.disabled = rp.disabled or role.disabled
        role.lastModified = Date.now()
        role.name = rp.name or role.name
        role.save (err) ->
          if err
          else
            reply role: role

  deleteRole: (request, reply) ->
    roleId = encodeURI request.params.roleId
    Role.findById roleId, (err, role) ->
      if err
        reply "Could not find the role. Please try again."
        console.log "Error: #{err}"
      else
        role.deleted = true
        role.save (err) ->
          if err
            reply "Could not delete the role. Please try again."
            console.log "Error: #{err}"
          else
            reply "The role has been deleted."

