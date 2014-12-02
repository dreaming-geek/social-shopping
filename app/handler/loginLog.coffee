models = require '../models'
LoginLog = models.LoginLog

module.exports =

  createLoginLog: (request, reply) ->
    rp = request.payload
    newLog = new LoginLog()
    newLog.lastModified = Date.now()
    newLog.ipAddress = rp.ipAddress
    newLog.deviceInfo = rp.deviceInfo
    newLog.userId = rp.userId
    newLog.save (err) ->
      reply err
    reply 'Log Created'

  getLoginLogs: (request, reply) ->
    LoginLog.find (err, logs) ->
      if err
        reply err
      reply logs: logs