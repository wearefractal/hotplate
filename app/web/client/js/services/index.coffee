define ["app/server"], (server, notify) ->
  (_, index) ->
    server.ready (services) ->

      server.sample "DesertJS", (res) ->
        $('#main').html index message: res