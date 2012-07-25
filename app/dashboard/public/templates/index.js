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
        buf.push('<center><h1>todos</h1><div><input id="Todo-text" placeholder="What needs to be done?" data-value=" archive.newTodo.text | orBlank "/><div id="todos-list" data-text=" archive.todos | list "></div></div><div data-text=" archive.todos.length | orZero "></div>items left</center>');
      }
      return buf.join("");
    }(o))[0], o);
  };
});