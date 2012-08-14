
define(["app/server", "app/routes", "app/notify"], function(server, routes, notify) {
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
      }
    }
  });
  return server.ready(function(services) {
    return console.log("Connected - Available services: " + services);
  });
});
