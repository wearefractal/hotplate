
define(["app/server", "app/routes"], function(server, routes) {
  return server.ready(function(services) {
    return console.log("Connected - Available services: " + services);
  });
});
