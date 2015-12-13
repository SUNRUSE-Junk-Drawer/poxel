add = require "./add"
cutTerrain = require "./cutTerrain"

# This module is not externally exposed, but is called by subtractBlock
# for each face of the block.
# It is used by addBlock/subtractBlock and takes:
# - The terrain object.
# - The facing direction (string, xn, yp, etc.) to remove a face on.
# - The facing direction (string, xn, yp, etc.) to add a face on.
# - An integer specifying a layer to work on.
# - An integer specifying the first axis of that layer to work on.
# - An integer specifying the second axis of that layer to work on.
# - A string specifying the material to add if a face is added.
# If a face exists at the location specified, facing specified by subtractFace, it is deleted.
# Otherwise, a new face is added in the location specified, facing specified by addFace, with the specified material.
module.exports = (terrain, subtractFace, addFace, layer, x, y, material) ->
	if not cutTerrain terrain, subtractFace, layer, x, y
		add terrain, addFace, layer, material, x, x + 1, y, y + 1
