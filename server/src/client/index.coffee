window.addEventListener "load", ->
	(require "./canvasSize")()
	(require "./canvasContext")()
	(require "./canvasRenderLoop")()
	(require "./socket")()
