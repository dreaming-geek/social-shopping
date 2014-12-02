mongoose = require 'mongoose'
Schema = mongoose.Schema
Mixed = Schema.Types.Mixed

addresseSchema = new Schema
  type: String
  streetAddress: String
  locality: String
  region: String
  postCode: String
  country: String
  primary: Boolean
  locationLng: Mixed
  locationLat: Mixed

phoneNumberSchema = new Schema
  type: String
  phoneNumber: String
  primary: Boolean

storeSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  name: String
  storeId: String
  addresses:[addresseSchema]
  phoneNumbers:[phoneNumberSchema]

module.exports = mongoose.model 'Store', storeSchema