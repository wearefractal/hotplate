define ["app/server", "app/notify"], (server, notify) ->
  (_, main) ->

    #vein.on 'ready', (services) ->

    ## archive

    archive = {}
      #todos: []
  
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

    # display main content

    main '#main', archive: archive
