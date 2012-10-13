connect = require "connect"
Vein = require "vein"
mongo = require "./lib/mongo"

# Web server
webServer = connect()
#webServer.use connect.responseTime()
webServer.use connect.favicon()
#webServer.use connect.limit config.images.maxsize
webServer.use connect.staticCache()
webServer.use connect.static app.paths.public

server = webServer.listen app.web.port

# Vein
global.vein = Vein.createServer server: server
global.vein.addFolder app.paths.services

console.log "Server started on #{app.web.port}"
console.log "Using database #{app.mongo.host}"