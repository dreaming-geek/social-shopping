handler = require '../handler'
module.exports = (server) ->
  server.route
    method: 'GET'
    path: '/api/loginLog'
    handler: handler.loginLog.getLoginLogs

  server.route
    method: 'POST'
    path: '/api/loginLog'
    handler: handler.loginLog.createLoginLog