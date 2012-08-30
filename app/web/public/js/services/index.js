
define(["app/server"], function(server, notify) {
  return function(_, index) {
    return server.ready(function(services) {
      return $('#main').html(index());
    });
  };
});
