
define(["app/server", "app/routes", "app/notify"], function(server, routes, notify) {
  if (server == null) {
    return console.log("server not loaded");
  }
  return server.ready(function(services) {
    return console.log("Connected - Available services: " + services);
  });
});
