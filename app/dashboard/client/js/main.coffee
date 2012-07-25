define ["app/server", "app/routes", "app/notify"], (server, routes, notify) ->
  return console.log "server not loaded" unless server?
  server.ready (services) ->
    console.log "Connected - Available services: #{services}"

  #server.close (reason='Reload to re-establish') ->
  #  notify.error "Connection lost: #{reason}"