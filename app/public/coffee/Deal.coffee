App.DealsRoute = Ember.Route.extend
  model: ->
    this.store.find 'deal'

App.DealSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
  primary: '_id'
  attrs:
    tags: embedded: 'always'
    colors: embedded: 'always'
    sizes: embedded: 'always'

App.DealTag = DS.Model.extend
  tags: DS.belongsTo 'deal'
  label: DS.attr()

App.DealColor = DS.Model.extend
  tags: DS.belongsTo 'deal'
  label: DS.attr()

App.DealSize = DS.Model.extend
  tags: DS.belongsTo 'deal'
  label: DS.attr()

App.Deal = DS.Model.extend
  disabled: DS.attr()
  deleted: DS.attr()
  owner: DS.attr()
  owner: DS.attr()
  tags: DS.hasMany 'dealTag'
  colors: DS.hasMany 'dealColor'
  sizes: DS.hasMany 'dealSize'