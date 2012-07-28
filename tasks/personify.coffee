module.exports = (grunt) ->
  grunt.registerMultiTask "personify", "parse contract", ->
    file = grunt.file.expandFiles(@file.src)[0]
    contract = require file

    # TODO: package.json
    grunt.log.writeln "package.json"

    # models
    grunt.log.writeln "models"
    for model, v of contract.models
      # description 
      if typeof v is String
        desc = v
        grunt.file.write "#{app.paths.models}/#{model}.coffee", 
          "# #{desc}  \n\n" +
          "#{model} = \n" +
          "\t" +
          "\n\n\n" +
          "module.exports = #{model}"
      # full model
      else
        m = v.toString()
        grunt.file.write "#{app.paths.models}/#{model}.coffee", 
          "#{model} = \n" +
          "\t#{m}" + # to coffee obj
          "\n\n\n" +
          "module.exports = #{model}"
 
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
    