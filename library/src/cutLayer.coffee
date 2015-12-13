cutQuadrilateralSet = require "./cutQuadrilateralSet"

module.exports = (layer, x, y) -> 
	for material, quadrilateralSet of layer
		if cutQuadrilateralSet quadrilateralSet, x, y then return true
	false
