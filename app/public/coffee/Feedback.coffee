App.FeedbackRoute = Ember.Route.extend
  model: ->
    this.store.find 'feedback'

App.FeedbackSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  primaryKey: '_id'
  attrs:
    responses: embedded: 'always'
    choices: embedded: 'always'

App.FeedbackResponse = DS.Model.extend
  feedback: DS.belongsTo 'feedback'
  userId: DS.attr()
  response: DS.attr()
  disabled: DS.attr()
  deleted: DS.attr()

App.FeedbackChoice = DS.Model.extend
  feedback: DS.belongsTo 'feedback'
  label: DS.attr()
  order: DS.attr()

App.Feedback = DS.Model.extend
  disabled: DS.attr()
  deleted: DS.attr()
  owner: DS.attr()
  title: DS.attr()
  image: DS.attr()
  video: DS.attr()
  responses: DS.hasMany 'feedbackResponse'
  choices: DS.hasMany 'feedbackChoice'
