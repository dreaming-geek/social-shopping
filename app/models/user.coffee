mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId
Mixed = Schema.Types.Mixed

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

whichNotificationSchema = new Schema
  name: String
  enabled: Boolean

gpsVisibilitySchema = new Schema
  type: String
  name: String
  enabled: Boolean

reportSchema = new Schema
  deleted: Boolean
  disabled: Boolean
  lastModified: Date
  module: String
  recordId: ObjectId
  reason: String


userSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type: Date, default: Date.now
  lastLogin: type: Date, default: Date.now
  crmId: Number
  joinDate: type:Date, default: Date.now
  screenName: String
  firstName: String
  emailAddress: String
  passwordHash: String
  addresses:[addresseSchema]
  phoneNumbers:[phoneNumberSchema]
  birthday: Date
  bio: String
  gender: String
  avatar: String
  source: String
  brandId: Mixed
  roleId: Mixed
  personaId: Mixed
  settings:
    publicProfile: type:Boolean, default: false
    pushNotifications: type:Boolean, default: false
    whichNotifications:[whichNotificationSchema]
    gps: Boolean
    gpsVisibility:[gpsVisibilitySchema]
  reports:[reportSchema]

module.exports = mongoose.model 'User', userSchema