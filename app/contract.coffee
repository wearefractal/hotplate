module.exports = 
  name: "todos"
  goal: "keep track of todos"

  models:
    Todo: "something todo"

  archive:
    todos: 'Todo.vector'

  views:
    index:
     route: '/'
     include: 'Todo.crud'