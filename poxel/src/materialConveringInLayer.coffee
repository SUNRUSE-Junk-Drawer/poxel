quadrilateralSetCovers = require "./quadrilateralSetCovers"

module.exports = (layer, x, y) ->
	for key, value of layer
		if quadrilateralSetCovers value, x, y then return key
	null
