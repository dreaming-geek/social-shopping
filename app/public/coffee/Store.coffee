App.StoreRoute = Ember.Route.extend
  model: ->
    this.store.find 'store'

#App.StoreModelSerializer = DS.RESTSerializer.extend DS.EmbeddedRecordsMixin,
#  primaryKey: '_id'
#  attrs:
#    phoneNumbers: embedded: 'always'

#App.StorePhone = DS.Model.extend
#  storeModel: DS.belongsTo 'storeModel'
#  type: DS.attr()

App.StoreModel = DS.Model.extend
  storeId: DS.attr()
  name: DS.attr()
  disabled: DS.attr()
  deleted: DS.attr()
#  phoneNumbers: DS.hasMany 'storePhone'