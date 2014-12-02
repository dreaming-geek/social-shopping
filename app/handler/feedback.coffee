model = require '../models'
Feedback = model.Feedback

module.exports =
  getFeedbackAll: (request, reply) ->
    Feedback.find (err, feedback) ->
      if err
        reply "There was an error with this request. Please try again."
        console.log "Error: #{err}"
      reply feedback: feedback

  getFeedback: (request, reply) ->
    feedbackId = encodeURI request.params.feedbackId
    Feedback.findById feedbackId, (err, feedback) ->
      if err
        reply "Could not find the feedback. Please try again."
        console.log "Error #{err}"
      reply feedback: feedback

  createFeedback: (request, reply) ->
    rp = request.payload
    newFeedback = new Feedback()
    newFeedback.owner = rp.owner
    newFeedback.title = rp.title
    newFeedback.content = rp.content
    newFeedback.image = rp.image
    newFeedback.video = rp.video
    if rp.newChoices #true/false
      newFeedback.choices = [
        label: rp.choiceLabel
        order: rp.choiceOrder
      ]
    if rp.newResponses
      newFeedback.responses = [
        userId: rp.userId
        response: rp.response
      ]
    newFeedback.save (err) ->
      if err
        reply "Could not save the feedback. Please try again."
        console.log "Error: #{err}"
      reply feedback: newFeedback

  updateFeedback: (request, reply) ->
    rp = request.payload
    feedbackId = encodeURI request.params.feedbackId
    Feedback.findById feedbackId, (err, feedback) ->
      if err
        reply "Could not find the feedback. Please try again."
        console.log "Error: #{err}"
      else
        feedback.deleted = rp.deleted or feedback.deleted
        feedback.disabled = rp.disabled or feedback.disabled
        feedback.lastModified = Date.now()
        feedback.owner = rp.owner or feedback.owner
        feedback.title = rp.title or feedback.title
        feedback.content = rp.content or feedback.content
        feedback.image = rp.image or feedback.image
        feedback.video = rp.video or feedback.video
        if rp.newChoice
          feedback.choices.push
            label: rp.choiceLabel
            order: rp.choiceOrder
        if rp.newResponse
          feedback.responses.push
            userId: rp.responseUserId
            response: rp.responseResponse
        feedback.save (err) ->
          if err
            reply "Could not save the feedback. Please try again."
            console.log "Error: #{err}"
          else
            reply feedback: feedback

  updateFeedbackChoices: (request, reply) ->
    rp = request.payload
    feedbackId = encodeURI request.params.feedbackId
    choiceId = rp.choiceId #choiceId is required
    if not choiceId
      reply "Please select a choice to modify."
    else
      Feedback.findById feedbackId, (err, feedback) ->
        if err
          reply "Could not find the feedback specified. Please try again."
          console.log "Error: #{err}"
        else
          choice = feedback.choices.id choiceId
          choice.deleted = rp.deleted or choice.deleted
          choice.disabled = rp.disabled or choice.disabled
          choice.lastModified = Date.now()
          choice.label = rp.choiceLabel or choice.label
          choice.order = rp.choiceOrder or choice.order
          feedback.save (err) ->
            if err
              reply "Could not save the choices. Please try again."
            else
              reply choice: choice

  updateFeedbackResponses: (request, reply) ->
    rp = request.payload
    feedbackId = encodeURI request.params.feedbackId
    responseId = rp.responseId #responseId is required
    if not responseId
      reply "Please select a response to modify."
    else
      Feedback.findById feedbackId, (err, feedback) ->
        if err
          reply "Could not find the feedback specified. Please try again."
          console.log "Error: #{err}"
        else
          response = feedback.responses.id responseId
          response.deleted = rp.deleted or response.deleted
          response.disabled = rp.disabled or response.disabled
          response.lastModified = Date.now()
          response.userId = rp.userId or response.userId
          response.response = rp.response or response.response
          feedback.save (err) ->
            if err
              reply "Could not save the response. Please try again."
            else
              reply response: response

  deleteFeedback: (request, reply) ->
    feedbackId = encodeURI request.params.feedbackId
    Feedback.findById feedbackId, (err, feedback) ->
      if err
        reply "Could not find the feedback. Please try again."
        console.log "Error: #{err}"
      else
        feedback.deleted = true
        feedback.save (err) ->
          if err
            reply "Could not delete the feedback. Please try again."
            console.log "Error: #{err}"
          else
            reply "The feedback has been deleted." 