
define(["app/server", "app/notify"], function(server, notify) {
  return function(_, main) {
    return server.on('ready', function() {
      var archive;
      console.log("ready");
      archive = {};
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
      return main('#main', {
        archive: archive
      });
    });
  };
});
