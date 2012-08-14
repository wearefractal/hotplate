define ->
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
      orBlank: (val) -> val or ""
      orZero: (val) -> val or 0