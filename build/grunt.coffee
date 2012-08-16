path   = require 'path'
fs     = require 'fs'
coffee = require 'coffee-script'
global.app = require "./config"

gruntConfig =
  pkg: "<json:package.json>"
  test:
    files: [ "tests/**/*.js" ]

    #exec: 
    # http://github.com/wearefractal/jaded
    #jaded: 
    # -r for rivets binding
    #  command: "#{app.paths.npmBin}/jaded -dra -i ./app/web/client/templates -o ./app/web/public/templates"

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
        "app/web/public/":           "#{app.paths.client}/index.html"

  ##
  ## watch
  ##

  watch:
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
  grunt.registerTask "default", "copy jaded lint test coffee reload start watch"

  ## start to
  grunt.registerTask "start", "start up servers", ->
    grunt.log.writeln "starting servers..."
    require "#{app.paths.server}/server"

 
  grunt.registerTask "jaded", "compile jaded templates", ->
    jaded = require 'jaded'
    console.log jaded
