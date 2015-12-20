express = require "express"
app = express()

http = require "http"
server = http.Server app

app.use "/", express.static __dirname + "/client"

configuration = require "./configuration"

socketIo = require "socket.io"
rootSocket = socketIo server
socket = require "./socket"
socket rootSocket

server.listen configuration.port
