quadrilateralCovers = require "./quadrilateralCovers"

module.exports = (quadrilaterals, x, y) ->
	for quadrilateral in quadrilaterals
		if quadrilateralCovers quadrilateral, x, y then return true
	false
