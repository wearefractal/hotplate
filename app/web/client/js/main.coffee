define ["app/server", "app/rivets", "app/routes", "app/notify"], 
	(server, rivets, routes, notify) ->
		server.ready (services) ->
			console.log "Connected - Available services: #{services}"