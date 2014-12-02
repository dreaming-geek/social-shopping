handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/feedbacks'
    handler: handler.feedback.getFeedbackAll

  server.route
    method: 'GET'
    path: '/api/feedbacks/{feedbackId}'
    handler: handler.feedback.getFeedback

  server.route
    method: 'POST'
    path: '/api/feedbacks'
    handler: handler.feedback.createFeedback

  server.route
    method: 'PUT'
    path: '/api/feedbacks/{feedbackId}'
    handler: handler.feedback.updateFeedback

  server.route
    method: 'PUT'
    path: '/api/feedbacks/choice/{feedbackId}'
    handler: handler.feedback.updateFeedbackChoices

  server.route
    method: 'PUT'
    path: '/api/feedbacks/response/{feedbackId}'
    handler: handler.feedback.updateFeedbackResponses

  server.route
    method: 'DELETE'
    path: '/api/feedbacks/{feedbackId}'
    handler: handler.feedback.deleteFeedback