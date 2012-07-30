module.exports = (grunt, prop, val) ->
  grunt.log.writeln "[ models ]"
  models = []
  for model, desc of val
    grunt.log.writeln "loading model: #{model}"
    if typeof(desc) is 'string'
      grunt.log.writeln "#{app.paths.models}/#{model}.coffee" 
      models[model] = {}
      models[model].desc = desc
      grunt.file.write "#{app.paths.models}/#{model}.coffee", 
        "module.exports = \n\n\t"
    else if typeof(desc) is 'object'
      models[model] = desc

  return models