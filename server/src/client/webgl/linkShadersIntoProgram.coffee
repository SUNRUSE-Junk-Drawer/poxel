canvasContext = require "./../canvasContext"
setState = require "./../setState"

module.exports = (vertex, fragment) ->
	gl = canvasContext.instance
	program = canvasContext.instance.createProgram()
	gl.attachShader program, vertex
	gl.attachShader program, fragment
	gl.linkProgram program
	gl.detachShader program, vertex
	gl.detachShader program, fragment
	if gl.getProgramParameter program, gl.LINK_STATUS
		program
	else
		details = gl.getProgramInfoLog program
		setState "webGlLinkingError", details
		throw new Error "Failed to link a WebGL program; " + details
