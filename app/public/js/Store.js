// Generated by CoffeeScript 1.8.0
(function() {
  App.StoreRoute = Ember.Route.extend({
    model: function() {
      return this.store.find('store');
    }
  });

  App.StoreModel = DS.Model.extend({
    storeId: DS.attr(),
    name: DS.attr(),
    disabled: DS.attr(),
    deleted: DS.attr()
  });

}).call(this);