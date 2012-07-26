nestObj = function(obj, keypath) {
  var k, last, ref, _i, _len;
  if (ref = keypath.split(".")) {
    last = ref.pop();
    for (_i = 0, _len = ref.length; _i < _len; _i++) {
      k = ref[_i];
      if (obj[k] != null) {
        obj = obj[k];
      }
    }
  }
  return {
    result: obj,
    prop: last
  };
};
Collection = (function() {

  function Collection() {
    this.list = [];
    this.length = 0;
  }

  Collection.prototype.add = function(item) {
    this.list.push(item);
    return this.length++;
  };

  Collection.prototype.remove = function(item) {};

  Collection.prototype.get = function() {
    return list;
  };

  return Collection;

})();
Archive = (function() {

  function Archive(obj) {
    this.vars = obj;
  }

  Archive.prototype.set = function(keypath, val, next) {
    var prop, res, result, _ref;
    console.log("Archive.set");
    console.log(keypath, val);
    console.log(typeof this.vars);
    _ref = nestObj(this.vars, keypath), result = _ref.result, prop = _ref.prop;
    console.log("result, prop");
    console.log(result, prop);
    res = result[prop];
    this.vars[res] = val;
    console.log("@vars");
    console.log(this.vars);
    return typeof next === "function" ? next(true) : void 0;
  };

  Archive.prototype.get = function(keypath, next) {
    return typeof next === "function" ? next(null, this.vars[keypath]) : void 0;
  };

  return Archive;

})();
Todo = (function() {

  function Todo(obj) {
    this.text = "foo";
  }

  Todo.prototype.set = function(keypath, val) {
    console.log("Todo.set:");
    return console.log(keypath, val);
  };

  return Todo;

})();
templates = [];
templates['Todo'] = function(todo) {
  return "<div>" + todo.text + "</div>";
};
define(["app/server", "app/notify"], function(server, notify) {
  return function(_, main) {
    return server.ready(function() {
      var archive;
      archive = new Archive({
        newTodo: new Todo({
          addTo: this.todos
        }),
        todos: new Collection('todos'),
        foo: {
          text: "bar"
        }
      });
      rivets.configure({
        adapter: {
          subscribe: function(obj, keypath, callback) {
            console.log("sub");
            return console.log(obj, keypath);
          },
          read: function(obj, keypath) {
            console.log("read");
            return console.log(obj, keypath);
          },
          publish: function(obj, keypath, value) {
            return obj.set(keypath, value);
          }
        }
      });
      rivets.configure({
        formatters: {
          orBlank: function(val) {
            if (val == null) {
              return "";
            }
          },
          orZero: function(val) {
            if (val == null) {
              return "0";
            }
          },
          list: function(val) {
            console.log("list");
            return console.log(val);
          }
        }
      });
      return main('#main', {
        archive: archive
      });
    });
  };
});