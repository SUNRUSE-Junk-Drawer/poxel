optimisePlane = require "./optimisePlane"

module.exports = (terrain) ->
	found = false
	(found = (optimisePlane plane) or found) for name, plane of terrain
	found
