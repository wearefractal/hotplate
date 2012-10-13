
define(["app/server"], function(server, notify) {
  return function(_, index) {
    return server.ready(function(services) {
      return server.sample("DesertJS", function(res) {
        return $('#main').html(index({
          message: res
        }));
      });
    });
  };
});
