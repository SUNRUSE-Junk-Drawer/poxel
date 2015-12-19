optimiseQuadrilateralSet = require "./optimiseQuadrilateralSet"

module.exports = (layer) ->
	found = false
	(found = (optimiseQuadrilateralSet quadrilateralSet) or found) for material, quadrilateralSet of layer
	found
