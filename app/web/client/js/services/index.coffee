define ["app/server"], (server, notify) ->
  (_, index) ->
    server.ready (services) ->

      server.sample "phoenix", (res) ->
        $('#main').html index message: res