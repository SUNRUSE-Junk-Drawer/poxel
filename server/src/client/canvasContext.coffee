setState = require "./setState"

module.exports = ->
	module.exports.instance = (document.getElementsByTagName "canvas")[0].getContext "webgl"
	if not module.exports.instance
		setState "noWebGl"
		throw new Error "No WebGL context is available"
