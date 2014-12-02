App.EventsRoute = Ember.Route.extend
  model: ->
    this.store.find('event')

App.EventSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  primaryKey: '_id'
  attrs:
    rsvps: embedded: 'always'
    tags: embedded: 'always'



App.Rsvp = DS.Model.extend
  event: DS.belongsTo 'event'
  userId: DS.attr()
  disabled: DS.attr()
  deleted: DS.attr()

App.Tag = DS.Model.extend
  event: DS.belongsTo 'event'
  label: DS.attr()
  disabled: DS.attr()
  deleted: DS.attr()

App.Event = DS.Model.extend
  disabled: DS.attr 'boolean'
  deleted: DS.attr 'boolean'
  owner: DS.attr 'string'
  ownerId: DS.attr 'string'
  locationType: DS.attr 'string'
  image: DS.attr 'string'
  video: DS.attr 'string'
  description: DS.attr 'string'
  title: DS.attr 'string'
  allowRsvp: DS.attr 'boolean'
  rsvps: DS.hasMany 'rsvp'
  tags: DS.hasMany 'tag'

