define ["app/server", "app/notify"], (server, notify) ->
  (_, index) ->
  
    server.ready (services) ->
      ## archive
      archive = {}
        #todos: []
      # display main content
      index '#main', archive: archive
      server.sample 45, (r) ->
