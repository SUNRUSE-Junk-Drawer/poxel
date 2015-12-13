cutLayer = require "./cutLayer"

module.exports = (terrain, facing, layer, x, y) ->
	layerInstance = terrain[facing]?[layer]
	if not layerInstance
		false
	else
		cutLayer layerInstance, x, y
