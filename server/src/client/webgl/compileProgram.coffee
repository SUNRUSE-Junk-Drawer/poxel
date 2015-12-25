compileShader = require "./compileShader"
linkShadersIntoProgram = require "./linkShadersIntoProgram"
canvasContext = require "./../canvasContext"

module.exports = (vertexSource, fragmentSource) ->
	gl = canvasContext.instance
	vertex = compileShader gl.VERTEX_SHADER, vertexSource
	fragment = compileShader gl.FRAGMENT_SHADER, fragmentSource
	program = linkShadersIntoProgram vertex, fragment
	gl.deleteShader vertex
	gl.deleteShader fragment
	program
