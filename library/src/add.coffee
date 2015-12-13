module.exports = (terrain, facing, layer, material, xFrom, xTo, yFrom, yTo) ->
	facingInstance = terrain[facing]
	if not facingInstance
		facingInstance = terrain[facing] = {}
	
	layerInstance = facingInstance[layer]
	if not layerInstance
		layerInstance = facingInstance[layer] = {}

	materialInstance = layerInstance[material]
	if not materialInstance
		materialInstance = layerInstance[material] = [
			[[xFrom, xTo], [yFrom, yTo]]
		]
	else
		materialInstance.push [[xFrom, xTo], [yFrom, yTo]]
