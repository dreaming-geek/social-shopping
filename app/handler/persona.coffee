model = require '../models'
Persona = model.Persona

module.exports =
  getPersonaAll: (request, reply) ->
    Persona.find (err, personas) ->
      if err
        reply "There was an error with this request. Please try again."
        console.log "Error: #{err}"
      reply personas: personas

  getPersona: (request, reply) ->
    personaId = encodeURI request.params.personaId
    Brand.findById personaId, (err, persona) ->
      if err
        reply "Could not find the brand. Please try again later."
        console.log "Error #{err}"
      reply persona: persona

  createPersona: (request, reply) ->
    rp = request.payload
    newPersona = new Persona()
    newPersona.name = rp.name
    newPersona.save (err) ->
      if err
        reply "Could not create persona. Please try again."
        console.log "Error: #{err}"
      else
        reply persona: newPersona

  updatePersona: (request, reply) ->
    rp = request.payload
    personaId = encodeURI request.params.personaId
    Persona.findById personaId, (err, persona) ->
      if err
        reply "Could not find the persona. Please try again."
        console.log "Error: #{err}"
      else
        persona.deleted = rp.deleted or persona.deleted
        persona.disabled = rp.disabled or persona.disabled
        persona.lastModified = Date.now()
        persona.name = rp.name or persona.name
        persona.save (err) ->
          if err
            reply "Could not save the persona. Please try again."
            console.log "Error: #{err}"
          else
            reply persona: persona

  deletePersona: (request, reply) ->
    personaId = encodeURI request.params.personaId
    Persona.findById personaId, (err, role) ->
      if err
        reply "Could not find the persona. Please try again."
        console.log "Error: #{err}"
      else
        role.deleted = true
        role.save (err) ->
          if err
            reply "Could not delete the persona. Please try again."
            console.log "Error: #{err}"
          else
            reply "The persona has been deleted."