handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/'
    handler: handler.pages.pageIndex

  server.route
    method: '*'
    path: '/{p*}'
    handler: handler.pages.handler