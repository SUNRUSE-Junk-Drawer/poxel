configuration = require "./configuration"

socketIo = require "socket.io"
rootSocket = socketIo configuration.port
socket = require "./socket"
socket rootSocket
