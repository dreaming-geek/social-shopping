mongoose = require 'mongoose'
Schema = mongoose.Schema

personaSchema = new Schema
  deleted: type:Boolean, default:false
  disabled: type:Boolean, default:false
  lastModified: type:Date, default: Date.now
  name: String

module.exports = mongoose.model 'Persona', personaSchema