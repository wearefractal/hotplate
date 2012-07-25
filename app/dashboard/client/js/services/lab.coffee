
      # index
      #View 
      #  center:
      #    h1: "todos"
      #    "#TodoCrud": Todo.crud
      #    footer: "only #{todos.active.length()} left"

      #$("#new-Todo-text").bind 'data-on-change', ({currentTarget}) ->
      #  console.log "DATA ONCHANGE"

      #$("#new-Todo-text").change ({currentTarget}) ->
      #  console.log "changed"
        #Todo().text currentTarget.value, (err, todo) ->
        #  if err? then console.log err
        #  else 
        #    $("#Todos").html templates['Todo'] todo: todo


      ## bind
#      dermis.bind
#        @list
#          bind: 'Todo'
#          add: 'prepend'    

      ###
      center
        h1 todos
        #TodoList
          input#newTodo (
            enter = ${todos.push}
          )
          list#TodoList (
            method = prepend
            bind   = ${todos} 
          )

      center
        h1 todos
        #TodoList
          input#newTodo 
            enter @todos.push
          list#TodoList
            method: prepend
            bind:   @todos 

    ## index.jade

    center
      h1 todos
      #TodoList
      footer ${todos.length()} left

    ## TodoList.jade

    input (
      placeholder = "What needs to be done?"
      bind        = ${Todo.text}
      on-change   = ${todos.push}
    )
  
    #todos (
      add  = ${prepend}
      bind = ${todos} 
    )


      
    ## TodoUI

    hbox
      input(type="checkbox", on-click=${Todo.text.strikethrough})
      span ${Todo.text}

    
        


      #$("#content").html index

##form

    $('form').submit (e) ->
        e.preventDefault()
        for item in e.currentTarget.children
          todos.push item.value


View = (obj) ->
  for k, v of obj   
    # divs start with '#'
    if k[0] is "#"
      console.log "got a div: #{k}"
    # list
    if k is 'list'
      $("##{list.bind}.text").change ({currentTarget}) -> 
        template = @["#{list.bind}Template"]
        $("##{list.bind}s")[list.add] templates[list.bind] currentTarget.value
