mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId


brandRegionSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  brand: String
  regions:[]

rankSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  name: String
  pointMin: Number
  pointMax: Number

pointValuationSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  module: String
  action: String
  points: Number

badgeSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  module: String
  action: String
  threshold: String
  name: String
  asset: String

addresseSchema = new Schema
  type: String
  streetAddress: String
  extStreetAddress: String
  locality: String
  region: String
  postCode: String
  country: String
  primary: Boolean

phoneNumberSchema = new Schema
  type: String
  phoneNumber: String
  primary: Boolean


brandSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  lastLogin: type:Date, default: Date.now
  name: String
  addresses:[addresseSchema]
  phoneNumbers:[phoneNumberSchema]
  modules:
    feedback: type:Boolean, default: false
    deals: type:Boolean, default: false
    gallery: type:Boolean, default: false
    events: type:Boolean, default: false
  brandRegion:[brandRegionSchema]
  ranks:[rankSchema]
  pointValuations:[pointValuationSchema]
  badges:[badgeSchema]


module.exports = mongoose.model 'Brand', brandSchema