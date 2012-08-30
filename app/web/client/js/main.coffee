define ["app/server", "app/routes"], 
	(server, routes) ->
		server.ready (services) ->
			console.log "Connected - Available services: #{services}"