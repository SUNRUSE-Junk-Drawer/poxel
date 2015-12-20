module.exports = ->
	canvas = (document.getElementsByTagName "canvas")[0]
	canvas.width = window.innerWidth
	canvas.height = window.innerHeight
	window.addEventListener "resize", ->
		canvas.width = window.innerWidth
		canvas.height = window.innerHeight
