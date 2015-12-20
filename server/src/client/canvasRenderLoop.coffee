render = require "./render"

module.exports = ->
	toLoop = ->
		render()
		window.requestAnimationFrame toLoop
	toLoop()
