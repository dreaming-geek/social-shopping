mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId
Mixed = Schema.Types.Mixed

tagSchema = new Schema
  deleted: Boolean
  disabled: Boolean
  lastModified: Date
  label: String

assetSchema = new Schema
  deleted: Boolean
  disabled: Boolean
  lastModified: Date
  source: String
  type: String
  extension: String
  asset: String
  size: Number
  tags:[tagSchema]

albumSchema = new Schema
  deleted: Boolean
  disabled: Boolean
  lastModified: Date
  owner: String
  ownerId: Mixed
  title: String
  coverPhoto: String
  assets:[assetSchema]


module.exports = mongoose.model 'Album', albumSchema