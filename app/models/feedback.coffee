mongoose = require 'mongoose'
Schema = mongoose.Schema
Mixed = Schema.Types.Mixed

choiceSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  label: String
  order: Number

responseSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  userId: Mixed
  response: String

feedbackSchema = new Schema
  deleted: type:Boolean, default: false
  disabled: type:Boolean, default: false
  lastModified: type:Date, default: Date.now
  owner: String
  title: String
  content: String
  image: String
  video: String
  choices:[choiceSchema]
  responses:[responseSchema]

module.exports = mongoose.model 'Feedback', feedbackSchema