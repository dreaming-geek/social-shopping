mongoose = require 'mongoose'
Schema = mongoose.Schema
Mixed = Schema.Types.Mixed

memberSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  userId: Mixed

groupSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  owner: String
  ownerId: Mixed
  name: String
  members:[memberSchema]

module.exports = mongoose.model 'Group', groupSchema