module.exports = ->
	document.body.setAttribute "state", "connecting"
	rootSocket = io()
	rootSocket.on "connect", -> document.body.setAttribute "state", "connected"
	rootSocket.on "connect_error", -> document.body.setAttribute "state", "failedToConnect"
	rootSocket.on "connect_timeout", -> document.body.setAttribute "state", "connectionTimeout"
	rootSocket.on "reconnect", -> document.body.setAttribute "state", "connected"
	rootSocket.on "reconnecting", -> document.body.setAttribute "state", "reconnecting"
	rootSocket.on "reconnect_error", -> document.body.setAttribute "state", "failedToReconnect"
	rootSocket.on "reconnect_failed", -> document.body.setAttribute "state", "failedToReconnectPermanently"
