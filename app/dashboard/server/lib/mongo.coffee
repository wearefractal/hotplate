db     = require 'mongoose'
async  = require 'async'
config = require '../config'
{extname, basename} = require 'path'
{readdirSync} = require 'fs'

console.log config.mongo.host
db.connect config.mongo.host

##
## TODO: factor out
##

for file in readdirSync app.paths.models
  ext = extname file
  name = basename file, ext
  if require.extensions[ext]?
    db.model name, require "#{app.paths.models}/#{name}" if require "#{app.paths.models}/#{name}"
  
## this too

db.wipe = (cb) ->
  async.parallel (m.remove.bind m for _, m of db.models), cb


module.exports = db