nestObj = (obj, keypath) ->
  if ref  = keypath.split(".")
    last = ref.pop()
    obj  = obj[k] for k in ref when obj[k]?

  result: obj
  prop: last

class Collection
  constructor: ->
    @list = []
    @length = 0
  add: (item) -> 
    @list.push item
    @length++
  remove: (item) ->
  get: -> list


class Archive 
  constructor: (obj) ->
    @vars = obj
    #for k, v of obj 
    #  @vars[k] = v 
  set: (keypath, val, next) ->
    # validate
    # next err
    console.log "Archive.set"
    console.log keypath, val
    console.log typeof @vars
    {result, prop} = nestObj @vars, keypath
    console.log "result, prop"
    console.log result, prop
    res = result[prop]
    @vars[res] = val

    console.log "@vars"
    console.log @vars

    #if @vars[keypath]?.set? then @vars[keypath].set val
    #else @vars[keypath] = val 
    next? true
  get: (keypath, next) ->
    # access control
    # next err
    next? null, @vars[keypath] 

class Todo
  constructor: (obj) ->
    @text = "foo"
    #if addTo = obj[addTo]? 
     #addTo 
  set: (keypath, val) ->
    console.log "Todo.set:"
    console.log keypath, val

templates = []
templates['Todo'] = (todo) -> "<div>#{todo.text}</div>"

define ["app/server", "app/notify"], (server, notify) ->
  (_, main) ->
    server.ready ->            

      ## archive

      archive = new Archive
        newTodo: new Todo { addTo: @todos }
        todos:   new Collection 'todos'
        foo:
          text: "bar"

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
            #console.log "pub"            
            #console.log obj, keypath, value
            
            obj.set keypath, value
            
            # {result, prop} = nestObj obj, keypath
            #console.log result, prop
            #result[prop] = value
            
      rivets.configure
        formatters:
          orBlank: (val) -> 
            return "" unless val?
          orZero: (val) ->
            return "0" unless val?
          list: (val) ->
            console.log "list"
            console.log val


      # display main content

      main '#main', archive: archive

      #archive.vars.todos.add new Todo()

      #$('#Todo-list').html templates['Todo'] 
      #$("#content").html content(todos: todos) # [, locals]
      #$("#TodoList").html TodoList()
