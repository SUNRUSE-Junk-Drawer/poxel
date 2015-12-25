setState = require "./setState"

module.exports = ->
	setState "connecting"
	rootSocket = io()
	rootSocket.on "connect", -> setState "connected"
	rootSocket.on "connect_error", -> setState "failedToConnect"
	rootSocket.on "connect_timeout", -> setState "connectionTimeout"
	rootSocket.on "reconnect", -> setState "connected"
	rootSocket.on "reconnecting", -> setState "reconnecting"
	rootSocket.on "reconnect_error", -> setState "failedToReconnect"
	rootSocket.on "reconnect_failed", -> setState "failedToReconnectPermanently"
