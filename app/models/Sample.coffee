db = require 'mongoose'
{Schema} = db

yourModel = new Schema
  id:
    type: String
    required: true
    index:
      unique: true
      dropDups: true
  name:
    type: String
    required: true
    index:
      unique: true      
  category:
    type: String
    required: true


module.exports = yourModel