
define(["app/server", "app/rivets", "app/routes", "app/notify"], function(server, rivets, routes, notify) {
  return server.ready(function(services) {
    return console.log("Connected - Available services: " + services);
  });
});
