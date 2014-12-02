# Routes will go here
App.Router.map ->
  @.resource 'users'
  @.resource 'events'
  @.resource 'brands'
  @.resource 'store'
  @.resource 'deals'
  @.resource 'feedback'