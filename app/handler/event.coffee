models = require '../models'
Event = models.Event

module.exports =
  getEventAll: (request, reply) ->
    Event.find (err, event) ->
      if err
        reply "There was an error with this request. Please try again."
        console.log "Error: #{err}"
      reply events: event

  getEvent: (request, reply) ->
    eventId = encodeURI request.params.eventId
    Event.findById eventId, (err, event) ->
      if err
        reply "Could not find the event. Please try again."
        console.log "Error #{err}"
      reply event: event

  createEvent: (request, reply) ->
    rp = request.payload
    newEvent = new Event()
    newEvent.owner = rp.owner
    newEvent.ownerId = rp.ownerId
    newEvent.title = rp.title
    newEvent.description = rp.description
    if rp.newTags
      newEvent.tags = [
        label: rp.tagLabel
      ]
    newEvent.image = rp.image
    newEvent.video = rp.video
    newEvent.locationType = rp.locationType
    newEvent.locationStreetAddress = rp.locStreetAddress
    newEvent.locationExtstreetAddress = rp.locExtStreetAddress
    newEvent.locationLocality = rp.locLocality
    newEvent.locationRegion = rp.locRegion
    newEvent.locationPostCode = rp.locPostCode
    newEvent.locationCountry = rp.locCounty
    newEvent.locationPrimary = rp.locPrimary
    newEvent.locationLng = rp.locLng
    newEvent.locationLng = rp.locLat
    newEvent.startDate = new Date rp.startDate #yyyy,mm,dd
    newEvent.startTime = rp.startTime #00:00
    newEvent.endDate = new Date rp.endDate
    newEvent.endTime = rp.endTime
    newEvent.allowRsvp = rp.allowRsvp #true/false
    if rp.newRsvp #true/false
      newEvent.rsvps = [
        userId: rp.userId
      ]
    newEvent.save (err) ->
      if err
        reply "Could not save the event. Please try again."
        console.log "Error: #{err}"
      reply event: newEvent

  updateEvent: (request, reply) ->
    rp = request.payload
    eventId = encodeURI request.params.eventId
    Event.findById eventId, (err, event) ->
      if err
        reply "Could not find the event. Please try again."
        console.log "Error: #{err}"
      else
        event.deleted = rp.deleted or event.deleted
        event.disabled = rp.disabled or event.disabled
        event.lastModified = Date.now()
        event.owner = rp.owner or event.owner
        event.ownerId = rp.ownerId or event.ownerId
        event.title = rp.title or event.title
        event.description = rp.description or event.description
        if rp.newTags
          event.tags.push
            label: rp.tagsLabel
        event.image = rp.image or event.image
        event.video = rp.video or event.video
        event.locationType = rp.locType or event.locationType
        event.locationStreetAddress = rp.locationStreetAddress or event.locationStreetAddress
        event.locationExtstreetAddress = rp.locationExtstreetAddress or event.locationExtstreetAddress
        event.locationLocality = rp.locationLocality or event.locationLocality
        event.locationRegion = rp.locationRegion or event.locationRegion
        event.locationPostCode = rp.locationPostCode or event.locationPostCode
        event.locationCountry = rp.locationCountry or event.locationCountry
        event.locationPrimary = rp.locationPrimary or event.locationPostCode
        event.locationLng = rp.locationLng or event.locationLng
        event.locationLat = rp.locationLat or event.locationLat
        event.startDate = new Date rp.startDate or event.startDate
        event.startTime = rp.startTime or event.startTime #00:00
        event.endDate = new Date rp.endDate or event.endDate
        event.endTime = rp.endTime or event.endTime
        event.allowRsvp = rp.allowRsvp or event.allowRsvp #true/false
        if rp.newRsvp
          event.rsvps.push
            userId: rp.userId
        event.save (err) ->
          if err
            reply "Could not save the event. Please try again."
            console.log "Error: #{err}"
          else
            reply event: event

  updateEventTag: (request, reply) ->
    rp = request.payload
    eventId = encodeURI request.params.eventId
    tagId = rp.tagId #tagId is required
    if not tagId
      reply "Please select a tag to modify."
    else
      Event.findById eventId, (err, event) ->
        if err
          reply "Could not find the event specified. Please try again."
          console.log "Error: #{err}"
        else
          tag = event.tags.id tagId
          tag.deleted = rp.deleted or tag.deleted
          tag.disabled = rp.disabled or tag.disabled
          tag.lastModified = Date.now()
          tag.label = rp.tagLabel or tag.label
          event.save (err) ->
            if err
              reply "Could not save the tag. Please try again."
            else
              reply tag: tag

  updateEventRsvp: (request, reply) ->
    rp = request.payload
    eventId = encodeURI request.params.eventId
    rsvpId = rp.rsvpId #rsvpId is required
    if not rsvpId
      reply "Please select an rsvp to modify."
    else
      Event.findById eventId, (err, event) ->
        if err
          reply "Could not find the event specified. Please try again."
          console.log "Error: #{err}"
        else
          rsvp = event.rsvps.id rsvpId
          rsvp.deleted = rp.deleted or rsvp.deleted
          rsvp.disabled = rp.disabled or rsvp.disabled
          rsvp.lastModified = Date.now()
          rsvp.userId = rp.userId or rsvp.userId
          event.save (err) ->
            if err
              reply "Could not save the rsvp. Please try again."
            else
              reply rsvp: rsvp

  deleteEvent: (request, reply) ->
    eventId = encodeURI request.params.eventId
    Event.findById eventId, (err, event) ->
      if err
        reply "Could not find the event. Please try again."
        console.log "Error: #{err}"
      else
        event.deleted = true
        event.save (err) ->
          if err
            reply "Could not delete the event. Please try again."
            console.log "Error: #{err}"
          else
            reply "The event has been deleted." 
