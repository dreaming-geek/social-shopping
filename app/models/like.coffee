mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

likeSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default:Date.now
  module: String
  recordId: type:ObjectId, index:true
  userId: type:String, index:true, required:true

module.exports = mongoose.model 'Like', likeSchema