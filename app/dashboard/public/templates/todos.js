define(function() {
  return function anonymous(target, o, op) {
    if (!op) {
      op = "html";
    }
    return rivets.bind($(target)[op](function anonymous(locals, attrs, escape, rethrow, merge) {
      attrs = attrs || jade.attrs;
      escape = escape || jade.escape;
      rethrow = rethrow || jade.rethrow;
      merge = merge || jade.merge;
      var buf = [];
      with (locals || {}) {
        var interp;
        (function() {
          if ("number" == typeof todos.length) {
            for (var $index = 0, $$l = todos.length; $index < $$l; $index++) {
              var todo = todos[$index];
              buf.push("Todo");
            }
          } else {
            for (var $index in todos) {
              var todo = todos[$index];
              buf.push("Todo");
            }
          }
        }).call(this);
      }
      return buf.join("");
    }(o))[0], o);
  };
});