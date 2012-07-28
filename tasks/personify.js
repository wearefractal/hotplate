module.exports = function(grunt) {
  return grunt.registerMultiTask("personify", "parse contract", function() {
    var contract, crud, desc, file, genEl, k, m, model, opts, templ, v, view, viewSchema, _ref, _ref1, _results;
    file = grunt.file.expandFiles(this.file.src)[0];
    contract = require(file);
    grunt.log.writeln("package.json");
    grunt.log.writeln("models");
    _ref = contract.models;
    for (model in _ref) {
      v = _ref[model];
      if (typeof v === String) {
        desc = v;
        grunt.file.write("" + app.paths.models + "/" + model + ".coffee", ("# " + desc + "  \n\n") + ("" + model + " = \n") + "\t" + "\n\n\n" + ("module.exports = " + model));
      } else {
        m = v.toString();
        grunt.file.write("" + app.paths.models + "/" + model + ".coffee", ("" + model + " = \n") + ("\t" + m) + "\n\n\n" + ("module.exports = " + model));
      }
    }
    grunt.log.writeln("archive");
    grunt.log.writeln("services");
    genEl = function(modelName, propName, opts) {
      return "#" + modelName + "-" + propName + "\n\n";
    };
    crud = function(modelName) {
      var k, templ;
      model = contract.models[modelName];
      templ = "";
      for (k in model) {
        v = model[k];
        if (typeof v === 'function') {
          templ += genEl(modelName, k, v);
        } else if (typeof v === 'object' && !Array.isArray(v) && Object.keys(v).length > 0) {
          templ = "TODO";
        }
        return templ;
      }
    };
    viewSchema = {
      include: function(f) {
        return "include " + f;
      }
    };
    grunt.log.writeln("views");
    _ref1 = contract.views;
    _results = [];
    for (view in _ref1) {
      opts = _ref1[view];
      templ = "h1 " + contract.name + "\n";
      for (k in opts) {
        v = opts[k];
        if (viewSchema[k] != null) {
          templ += viewSchema[k](v);
        }
      }
      _results.push(grunt.file.write("" + app.paths.client + "/templates/" + view + ".jade", templ));
    }
    return _results;
  });
};