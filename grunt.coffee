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
##    coffeecup: 
##      command: "#{app.paths.npmBin}/coffeecup -o #{app.paths.public}/templates --js #{app.paths.client}/templates"

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

#    grunt.log.writeln JSON.parse( coffee.compile(contract, bare:true) )
    grunt.log.writeln "generating package.json.."
    for model, desc of contract.models
      grunt.file.write "#{app.paths.models}/#{model}.coffee", 
        "# #{desc}  \n\n" +
        "#{model} = \n" +
        "\t" +
        "\n\n\n" +
        "module.exports = #{model}"      