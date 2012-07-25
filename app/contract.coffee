todos =   
  name: "todos"
  goal: "keep track of todos"

  models:
    Todo:
      text: String
      done: Boolean

  archive:
    todos: 'Todo.vector'

  views:
    index:
     route: '/'
     include: 'Todo.crud'


module.exports = todos