controller = require "./controller"
keyboardMappings = require "./keyboardMappings"

module.exports = ->
	window.addEventListener "keydown", (e) -> 
		if keyboardMappings[e.keyCode] then controller[keyboardMappings[e.keyCode]] = 1
	window.addEventListener "keyup", (e) -> 
		if keyboardMappings[e.keyCode] then controller[keyboardMappings[e.keyCode]] = 0
