quadrilateralsCover = require "./quadrilateralsCover"

module.exports = (layer, x, y) ->
	for key, value of layer
		if quadrilateralsCover value, x, y then return key
	null
