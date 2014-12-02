models = require '../models'
Group = models.Group

module.exports =
  getGroupsAll: (request, reply) ->
    Group.find (err, group) ->
      if err
        reply "There was an error with this request. Please try again."
        console.log "Error: #{err}"
      reply groups: group

  getGroup: (request, reply) ->
    groupId = encodeURI request.params.groupId
    Group.findById groupId, (err, group) ->
      if err
        reply "Could not find the group. Please try again."
        console.log "Error #{err}"
      reply group: group

  createGroup: (request, reply) ->
    rp = request.payload
    newGroup = new Group()
    newGroup.owner = rp.owner
    newGroup.ownerId = rp.ownerId
    newGroup.name = rp.name
    if rp.newMembers #true/false
      newGroup.members = [
        userId: rp.userId
      ]
    newGroup.save (err) ->
      if err
        reply "Could not save the group. Please try again."
        console.log "Error: #{err}"
      reply group: newGroup

  updateGroup: (request, reply) ->
    rp = request.payload
    groupId = encodeURI request.params.groupId
    Group.findById groupId, (err, group) ->
      if err
        reply "Could not find the group. Please try again."
        console.log "Error: #{err}"
      else
        group.deleted = rp.deleted or group.deleted
        group.disabled = rp.disabled or group.disabled
        group.lastModified = Date.now()
        group.owner = rp.owner or group.owner
        group.ownerId = rp.ownerId or group.ownerId
        group.name = rp.name or group.name
        if rp.newMembers #true/false
          group.members.push
            userId: rp.userId
        group.save (err) ->
          if err
            reply "Could not save the group. Please try again."
            console.log "Error: #{err}"
          else
            reply group: group

  deleteGroupMember: (request, reply) ->
    rp = request.payload
    groupId = encodeURI request.params.groupId
    memberId = rp.memberId #required
    if not memberId
      reply "Please select a member to modify."
    else
      Group.findById groupId, (err, group) ->
        if err
          reply "Could not find the group specified. Please try again."
          console.log "Error: #{err}"
        else
          member = group.members.id(memberId).remove()
          member.deleted = true
          member.lastModified = Date.now()
          group.save (err) ->
            if err
              reply "Could not save the choices. Please try again."
            else
              reply "The member has been removed."

  deleteGroup: (request, reply) ->
    groupId = encodeURI request.params.groupId
    Group.findById groupId, (err, group) ->
      if err
        reply "Could not find the group. Please try again."
        console.log "Error: #{err}"
      else
        group.deleted = true
        group.save (err) ->
          if err
            reply "Could not delete the group. Please try again."
            console.log "Error: #{err}"
          else
            reply "The group has been deleted." 