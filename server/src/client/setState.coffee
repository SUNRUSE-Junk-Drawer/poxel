module.exports = (state, details) ->
	if details is undefined
		document.body.removeAttribute "details"
	else
		document.body.setAttribute "details", details
	document.body.setAttribute "state", state
