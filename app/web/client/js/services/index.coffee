define ["app/server"], (server, notify) ->
  (_, index) ->
    server.ready (services) ->
      ## archive
      archive = {}

      # display main content
      index '#main', archive: archive
      server.sample 45, (r) ->
