module.exports = ->
	module.exports.instance = (document.getElementsByTagName "canvas")[0].getContext "webgl"
	if not module.exports.instance
		document.body.setAttribute "state", "noWebGl"
		throw new Error "No WebGL context is available"
