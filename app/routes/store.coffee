handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/stores'
    handler: handler.store.getStoresAll

  server.route
    method: 'GET'
    path: '/api/stores/{storeId}'
    handler: handler.store.getStore

  server.route
    method: 'POST'
    path: '/api/stores'
    handler: handler.store.createStore

  server.route
    method: 'PUT'
    path: '/api/stores/{storeId}'
    handler: handler.store.updateStore

  server.route
    method: 'PUT'
    path: '/api/stores/address/{storeId}'
    handler: handler.store.updateStoreAddress

  server.route
    method: 'PUT'
    path: '/api/stores/phone/{storeId}'
    handler: handler.store.updateStorePhone

  server.route
    method: 'DELETE'
    path: '/api/stores/{storeId}'
    handler: handler.store.deleteStore
