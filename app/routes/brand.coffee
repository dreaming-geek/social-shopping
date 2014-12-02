handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/brands'
    handler: handler.brand.getBrandAll

  server.route
    method: 'GET'
    path: '/api/brands/{brandId}'
    handler: handler.brand.getBrand

  server.route
    method: 'POST'
    path: '/api/brands'
    handler: handler.brand.createBrand

  server.route
    method: 'PUT'
    path: '/api/brands/{brandId}'
    handler: handler.brand.updateBrand

  server.route
    method: 'DELETE'
    path: '/api/brands/{brandId}'
    handler: handler.brand.deleteBrand

  server.route
    method: 'PUT'
    path: '/api/brands/address/{brandId}'
    handler: handler.brand.updateBrandAddress

  server.route
    method: 'PUT'
    path: '/api/brands/phone/{brandId}'
    handler: handler.brand.updateBrandPhone

  server.route
    method: 'PUT'
    path: '/api/brands/region/{brandId}'
    handler: handler.brand.updateBrandRegion

  server.route
    method: 'PUT'
    path: '/api/brands/rank/{brandId}'
    handler: handler.brand.updateBrandRank

  server.route
    method: 'PUT'
    path: '/api/brands/valuation/{brandId}'
    handler: handler.brand.updateBrandValuation

  server.route
    method: 'PUT'
    path: '/api/brands/badge/{brandId}'
    handler: handler.brand.updateBrandBadge
