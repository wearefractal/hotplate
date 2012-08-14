define ["app/server", "app/routes", "app/notify"], 
	(server, routes, notify) ->

		## rivets
		rivets.configure 
		  adapter:
		    subscribe: (obj, keypath, callback) ->
		      console.log "sub"
		      console.log obj, keypath
		    read: (obj, keypath) ->
		      console.log "read"
		      console.log obj, keypath
		    publish: (obj, keypath, value) ->
		      console.log "pub"            
		      console.log obj, keypath, value            
		      
		rivets.configure
		  formatters:
		    orBlank: (val) -> 
		      return "" unless val?
		    orZero: (val) ->
		      return "0" unless val?

		server.ready (services) ->
			console.log "Connected - Available services: #{services}"

		#server.close (reason='Reload to re-establish') ->
		#  notify.error "Connection lost: #{reason}"