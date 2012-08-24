path   = require 'path'
fs     = require 'fs'
coffee = require 'coffee-script'
global.app = require "./config"

gruntConfig =
  pkg: "<json:package.json>"
  test:
    files: ["#{app.paths.app}/**/*.spec.coffee"]
  mocha: 
    options: 
      reporter:    'spec'
      ui:          'exports'
      ignoreLeaks: 'true'
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

    myTasks:
      src: [ "./tasks/*.coffee" ]
      dest:  "./tasks"
      options:
        bare: true


  reload: {}

  lint:
    files: [ "grunt.js", "lib/**/*.js", "test/**/*.js" ]

  # dest: src 
  copy:
    dist: 
      files: 
        "app/web/public/js/vendor/": "#{app.paths.client}/js/vendor/**"
        "app/web/public/css/":       "#{app.paths.client}/css/**"
        "app/web/public/img/":       "#{app.paths.client}/img/**"
        "app/web/public/dev/":       "#{app.paths.client}/dev/**"
        "app/web/public/":           "#{app.paths.client}/index.html"

  ##
  ## watch
  ##

  watch:
    test:
      files: "<config:test.files>"
      tasks: "test"
    services:
      files: "#{app.paths.app}/**/services/**/*.coffee"
      tasks: "test"
    client: 
      files: [
        "#{app.paths.client}/js/vendor/**",
        "#{app.paths.client}/css/**",
        "#{app.paths.client}/index.html"
      ]
      tasks: "copy reload"

    jaded:
      files: "#{app.paths.client}/templates/*.jade"
      tasks: "jaded reload"

    coffee:
      files: [ "<config:coffee.app.src>",
               "<config:coffee.services.src>",
               "<config:coffee.vendor.src>",  
               "<config:coffee.myTasks.src>" ]
      tasks: "coffee reload"    

  globals:
    exports: true


module.exports = (grunt) ->
  ## init config 
  grunt.initConfig gruntConfig

  grunt.loadNpmTasks "grunt-contrib"
  grunt.loadNpmTasks "grunt-coffee"   
  grunt.loadNpmTasks "grunt-reload"
  grunt.loadNpmTasks "grunt-exec"

  ## default 
  grunt.registerTask "default", 
    "copy jaded lint test coffee reload start watch"

  ## start
  grunt.registerTask "start", "start up servers", ->
    grunt.log.writeln "starting..."
    require "#{app.paths.server}/server"
    try
      require "#{app.paths.app}/start"
    catch e
      console.log e
  ## jaded
  grunt.registerTask "jaded", "compile jaded templates", ->
    jaded = require 'jaded'  
    {basename, extname}  = require 'path'
    src   = app.paths.client + '/templates'
    dest  = app.paths.public + '/templates'
    grunt.file.recurse src,
      (absolute, root, subdir, filename) ->
        name = basename filename, extname filename
        template = jaded.compile grunt.file.read(absolute), 
          development: true
          rivets: true
          amd: true
          filename: absolute
        grunt.file.write "#{dest}/#{name}.js", template

  grunt.registerMultiTask "test", "Run unit tests with Mocha", ->
    Mocha = require 'mocha'
    # tell grunt this is an asynchronous task
    done = @async()

    for key of require.cache
      if require.cache[key]
        delete require.cache[key]

        console.warn "Mocha grunt task: Could not delete from require cache:\n" + key  if require.cache[key]
      else
        console.warn "Mocha grunt task: Could not find key in require cache:\n" + key

    # load the options if they are specified
    if typeof options is 'object'
      options = grunt.config(["mocha", @target, "options"])
    else
      options = grunt.config("mocha.options") 
    
    # create a mocha instance with our options
    mocha = new Mocha(options)

    # add files to mocha
    for file in grunt.file.expandFiles(@file.src)
      mocha.addFile file

    # run mocha asynchronously and catch errors!! (again, in case we are running this task in watch)

    try
      mocha.run (failureCount) ->
        console.log "Mocha completed with " + failureCount + " failing tests"
        done failureCount is 0
    catch e
      console.log "Mocha exploded!"
      console.log e
      done false