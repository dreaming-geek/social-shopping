mongoose = require 'mongoose'
Schema = mongoose.Schema

roleSchema = new Schema
  deleted: type:Boolean, default:false
  disabled: type:Boolean, default:false
  lastModified: type:Date, defaule: Date.now
  name: String

module.exports = mongoose.model 'Role', roleSchema