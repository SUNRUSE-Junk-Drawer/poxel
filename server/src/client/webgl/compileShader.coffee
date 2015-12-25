canvasContext = require "./../canvasContext"
setState = require "./../setState"

module.exports = (type, source) ->
	gl = canvasContext.instance
	shader = gl.createShader type
	gl.shaderSource shader, source
	gl.compileShader shader
	if gl.getShaderParameter shader, gl.COMPILE_STATUS
		shader
	else
		details = gl.getShaderInfoLog shader
		setState "webGlCompilationError", details
		throw new Error "Failed to compile a WebGL shader; " + details
