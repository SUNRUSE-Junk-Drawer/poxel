poxel = require "poxel"
map = require "./../map"

module.exports = 
	schema: 
		type: "object"
		properties: 
			location:
				type: "array"
				minItems: 3
				maxItems: 3
				items:
					type: "integer"
			material:
				type: "string"
		additionalProperties: false
		required: ["location", "material"]
	handler: (rootSocket, socket, message) ->
		if (map.materials.indexOf message.material) is -1
			socket.emit "eventRejected", ["the requested material is not supported"]
		else
			if not poxel.blockInSurface map.terrain, message.location[0], message.location[1], message.location[2]
				socket.emit "eventRejected", ["the requested location is not in a surface"]
			else
				poxel.subtractBlock map.terrain, message.location[0], message.location[1], message.location[2], message.material
				rootSocket.emit "blockSubtracted", message
