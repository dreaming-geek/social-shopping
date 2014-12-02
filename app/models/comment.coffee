mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

commentSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default:Date.now
  module: String
  recordId: type:ObjectId, index:true
  userId: type:String, index:true, required:true
  comment: String

module.exports  = mongoose.model 'Comment', commentSchema