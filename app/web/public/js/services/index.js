
define(["app/server", "templates/index"], function(server, index) {
  return {
    show: function() {
      return server.ready(function(services) {
        return server.sample("test", function(msg) {
          return $('#main').html(index({
            message: msg
          }));
        });
      });
    }
  };
});
