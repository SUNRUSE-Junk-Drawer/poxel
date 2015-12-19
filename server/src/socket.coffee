jsonschema = require "jsonschema"
configuration = require "./configuration"
map = require "./map"

module.exports = (rootSocket) ->
	rootSocket.on "connection", (socket) ->
		for name in configuration.handlers
			do(name) ->
				handler = require "./handlers/" + name
				socket.on name, (message) ->
					result = jsonschema.validate message, handler.schema
					if result.errors.length
						socket.emit "eventRejected", (error.stack for error in result.errors)
					else
						handler.handler rootSocket, socket, message
		socket.emit "mapChanged", 
			terrain: map.terrain
			materials: map.materials
