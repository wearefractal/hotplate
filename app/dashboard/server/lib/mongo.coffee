db            = require 'mongoose'
async         = require 'async'
{readdirSync, extname, basename} = require 'fs'
config        = require '../config'

console.log config.mongo.host
db.connect config.mongo.host

##
## TODO: factor out
##

for file in readdirSync app.paths.models
  ext = extname file
  name = basename file, ext
  if require.extensions[ext]?
    try
	  db.model name, require "#{app.paths.models}/#{name}"
    catch e
	  console.log e
## this too

db.wipe = (cb) ->
  async.parallel (m.remove.bind m for _, m of db.models), cb


module.exports = db