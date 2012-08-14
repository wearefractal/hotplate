path = require 'path'

app = 
  name:       'hotplate'
  models:     []
  services:   []
  archive:    {}
  views:      []
  paths:
    root:     path.resolve '.'
    app:      path.resolve './app'
    models:   path.resolve './app/models'
    services: path.resolve './app/services'
    client:   path.resolve './app/web/client'
    server:   path.resolve './app/web/server'
    public:   path.resolve './app/web/public'
    npmBin:   path.resolve './node_modules/.bin'
  web:
    port: process.env.PORT or 8080

app.mongo = host: "mongodb://localhost:27017/#{app.name}"

module.exports = app