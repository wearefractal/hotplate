define ["app/server", "templates/index"], (server, index) ->
  show: ->
    server.ready (services) ->
      server.sample "test", (msg) ->
        $('#main').html index message: msg 
