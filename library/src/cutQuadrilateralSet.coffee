quadrilateralCovers = require "./quadrilateralCovers"

module.exports = (quadrilaterals, x, y) ->
	for quadrilateral, index in quadrilaterals
		if not quadrilateralCovers quadrilateral, x, y then continue
		quadrilaterals.splice index, 1
		if x > quadrilateral[0][0] then quadrilaterals.push [[quadrilateral[0][0], x], [quadrilateral[1][0], y + 1]]
		if x < quadrilateral[0][1] - 1 then quadrilaterals.push [[x + 1, quadrilateral[0][1]], [y, quadrilateral[1][1]]]
		if y > quadrilateral[1][0] then quadrilaterals.push [[x, quadrilateral[0][1]], [quadrilateral[1][0], y]]
		if y < quadrilateral[1][1] - 1 then quadrilaterals.push [[quadrilateral[0][0], x + 1], [y + 1, quadrilateral[1][1]]]
		return true
	false
