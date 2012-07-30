set = (grunt, prop, val) -> 
  grunt.log.writeln "app.#{prop}: #{val}"
  return val
  #app[prop] = val

contractSchema =
  name:     set
  goal:     set
  models:   require './services/models'
  #services: require './services/services'
  #archive:  require './services/archive'
  #views:    require './services/views'

module.exports = (grunt) ->
  grunt.registerMultiTask "personify", "parse contract", ->
    file = grunt.file.expandFiles(@file.src)[0]
    contract = require file
    grunt.log.writeln "-=[ personify ]=-"
    grunt.log.writeln "parsing contract: #{file}"
    for k, v of contract
      app[k] = contractSchema[k]? grunt, k, v 
    console.log app
###
    # archive
    grunt.log.writeln "archive"

    # TODO: services
    grunt.log.writeln "services"

    genEl = (modelName, propName, opts) ->
      "##{modelName}-#{propName}\n\n"

    crud = (modelName) -> 
      model = contract.models[modelName]
      templ = ""
      for k, v of model
        # simple type 
        if typeof v is 'function'
          templ += genEl modelName, k, v
        # object config
        else if typeof(v) is 'object' and !Array.isArray(v) and Object.keys(v).length > 0
          ## sdsd
          templ = "TODO"

        return templ

    viewSchema =
      include: (f) -> "include #{f}"
    # views
    grunt.log.writeln "views"
    for view, opts of contract.views
      templ = "h1 #{contract.name}\n"
      for k, v of opts
        templ += viewSchema[k] v if viewSchema[k]? 

      grunt.file.write "#{app.paths.client}/templates/#{view}.jade", templ
    