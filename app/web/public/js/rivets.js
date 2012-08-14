
define(function() {
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
        console.log("pub");
        return console.log(obj, keypath, value);
      }
    }
  });
  return rivets.configure({
    formatters: {
      orBlank: function(val) {
        return val || "";
      },
      orZero: function(val) {
        return val || 0;
      }
    }
  });
});
