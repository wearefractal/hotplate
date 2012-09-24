path   = require 'path'
fs     = require 'fs'
coffee = require 'coffee-script'
global.app = require "./config"

gruntConfig =
  pkg: "<json:package.json>"
  mocha: 
    all:
      src: ["#{app.paths.app}/**/*.spec.coffee"]
      dest: "#{app.paths.public}/templates"
      options: 
        reporter:    'spec'
        ui:          'exports'
        ignoreLeaks: 'true'
  jaded:
    app:
      src: [ "#{app.paths.client}/templates/*.jade" ]
      dest:  "#{app.paths.public}/templates"
      options:
        amd: true
        development: false
        rivets: false    
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
      files: "<config:jaded.app.src>"
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
  grunt.loadNpmTasks "grunt-jaded"

  ## default 
  grunt.registerTask "default", 
    "copy jaded lint coffee reload start watch"

  ## start
  grunt.registerTask "start", "start up servers", ->
    grunt.log.writeln "starting..."
    require "#{app.paths.server}/server"
    try
      require "#{app.paths.app}/start"
    catch e
      console.log e
