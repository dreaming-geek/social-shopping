// Generated by CoffeeScript 1.8.0
(function() {
  window.App = Ember.Application.create();

  App.ApplicationAdapter = DS.RESTAdapter.extend({
    host: 'http://localhost:3000/api'
  });

  App.ApplicationSerializer = DS.RESTSerializer.extend({
    primaryKey: '_id'
  });

}).call(this);