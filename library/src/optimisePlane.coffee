optimiseLayer = require "./optimiseLayer"

module.exports = (plane) -> 
	found = false
	(found = (optimiseLayer layer) or found) for location, layer of plane
	found
