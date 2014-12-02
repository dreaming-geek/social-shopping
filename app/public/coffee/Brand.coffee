App.BrandsRoute = Ember.Route.extend
  model: ->
    this.store.find 'brand'

App.Brand = DS.Model.extend
  name: DS.attr 'string'
