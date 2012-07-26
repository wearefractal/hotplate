path   = require 'path'
fs     = require 'fs'
coffee = require 'coffee-script'
global.app = require "./config"

gruntConfig =
  pkg: "<json:package.json>"
  test:
    files: [ "tests/**/*.js" ]

  exec: 
    # http://github.com/wearefractal/jaded
    jaded: 
      # -r for rivets binding
      command: "#{app.paths.npmBin}/jaded -dr -a \"jade\" -i ./app/dashboard/client/templates -o ./app/dashboard/public/templates"

  coffee:
    app:
      src: [ "#{app.paths.client}/js/*.coffee" ]
      dest:  "#{app.paths.public}/js"
      options:
        bare: true

    services:
      src: [ "#{app.paths.client}/js/services/*.coffee" ]
      dest:  "#{app.paths.public}/js/services"
      options:
        bare: true

    vendor:
      src: [ "#{app.paths.client}/js/vendor/*.coffee" ]
      dest:  "#{app.paths.public}/js/vendor"
      options:
        bare: true

  reload: {}

  lint:
    files: [ "grunt.js", "lib/**/*.js", "test/**/*.js" ]

  contract:
    files: "#{app.paths.app}/**/contract.coffee"

  ##
  ## watch
  ##

  watch:
    index:
      files: "#{app.paths.public}/index.html"
      tasks: "reload"

    # templates
    
    jaded:
      files: "#{app.paths.client}/templates/*.jade"
      tasks: "exec:jaded reload"

    contracts:
      files: "<config:contract.files>"
      tasks: "contract"

    coffee:
      files: [ "<config:coffee.app.src>",
               "<config:coffee.services.src>",
               "<config:coffee.vendor.src>"  ]
      tasks: "coffee reload"    

    styles:
      files: "#{app.paths.public}/css/styles.css"
      tasks: "reload"

  globals:
    exports: true


module.exports = (grunt) ->

  ## init config 
  
  grunt.initConfig gruntConfig

  grunt.loadNpmTasks "grunt-coffee"
  grunt.loadNpmTasks "grunt-reload"
  grunt.loadNpmTasks "grunt-exec"

  ## default 

  grunt.registerTask "default", "contract lint test coffee reload start watch"

  ## start 

  grunt.registerTask "start", "start up servers", ->
    grunt.log.writeln "starting servers..."
    require "#{app.paths.server}/server"

  grunt.registerMultiTask "contract", "parse contract", ->
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
    