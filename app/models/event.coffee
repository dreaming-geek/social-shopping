mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId
Mixed = Schema.Types.Mixed

tagSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  label: String

rsvpSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  userId: Mixed

eventSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  owner: String
  ownerId: Mixed
  title: String
  description: String
  tags:[tagSchema]
  image: String
  video: String
  locationType: String
  locationStreetAddress: String
  locationExtStreetAddress: String
  locationLocality: String
  locationRegion: String
  locationPostCode: String
  locationCountry: String
  locationPrimary: Boolean
  locationLng: Mixed
  locationLat: Mixed
  startDate: Date
  startTime: String
  endDate: Date
  endTime: String
  allowRsvp: Boolean
  rsvps:[rsvpSchema]

module.exports = mongoose.model 'Event', eventSchema