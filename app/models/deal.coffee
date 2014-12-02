mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId
Mixed = Schema.Types.Mixed

sizeSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  label: String

colorSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  label: String

tagSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  label: String

dealSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  owner: String
  ownerId: Mixed
  status: String
  source: String
  title: String
  product: String
  startDate: Date
  endDate: Date
  backgroundImage: String
  image: String
  video: String
  barCode: Number
  availableOnline: Boolean
  availableInStores: Boolean
  url: String
  locationType: String
  locationStreetAddress: String
  locationExtStreet: String
  locationLocality: String
  locationRegion: String
  locationPostCode: String
  locationCountry: String
  locationPrimary: Boolean
  locationLng: Mixed
  locationLat: Mixed
  description: String
  sizes:[sizeSchema]
  colors:[colorSchema]
  discountType: String
  discountAmount: String
  price: String
  tags:[tagSchema]

module.exports = mongoose.model 'Deal', dealSchema