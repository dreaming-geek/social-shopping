handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/deals'
    handler: handler.deal.getDealAll

  server.route
    method: 'GET'
    path: '/api/deals/{dealId}'
    handler: handler.deal.getDeal

  server.route
    method: 'POST'
    path: '/api/deals'
    handler: handler.deal.createDeal

  server.route
    method: 'PUT'
    path: '/api/deals/{dealId}'
    handler: handler.deal.updateDeal

  server.route
    method: 'PUT'
    path: '/api/deals/size/{dealId}'
    handler: handler.deal.updateDealSize

  server.route
    method: 'PUT'
    path: '/api/deals/color/{dealId}'
    handler: handler.deal.updateDealColor

  server.route
    method: 'PUT'
    path: '/api/deals/tag/{dealId}'
    handler: handler.deal.updateDealTag

  server.route
    method: 'DELETE'
    path: '/api/deals/{dealId}'
    handler: handler.deal.deleteDeal