window.addEventListener "load", ->
	(require "./socket")()
	(require "./canvasSize")()
	(require "./canvasRenderLoop")()
