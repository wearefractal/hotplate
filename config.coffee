# Todo: ports and 
# if port in use use port++

path = require 'path'
module.exports = 
  name: 'infiltrade'
  paths:
    root:     path.resolve '.'
    app:      path.resolve './app'
    models:   path.resolve './app/models'
    services: path.resolve './app/services'
    client:   path.resolve './app/dashboard/client'
    server:   path.resolve './app/dashboard/server'
    public:   path.resolve './app/dashboard/public'
    npmBin:   path.resolve './node_modules/.bin'
