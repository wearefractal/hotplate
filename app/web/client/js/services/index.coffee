define ["app/server"], (server, notify) ->
  (_, index) ->
    server.ready (services) ->

      # display main content
      $('#main').html index()      