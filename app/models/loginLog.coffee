mongoose = require 'mongoose'
Schema = mongoose.Schema
Mixed = Schema.Types.Mixed

loginLogSchema = new Schema
    lastModified: type:Date, default: Date.now
    ipAddress: String
    deviceInfo: String
    userId = Mixed

module.exports = mongoose.model 'LoginLog', loginLogSchema