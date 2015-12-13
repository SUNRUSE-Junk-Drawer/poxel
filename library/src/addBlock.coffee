changeBlockFace = require "./changeBlockFace"

module.exports = (terrain, x, y, z, material) ->
	changeBlockFace terrain, "xp", "xn", x, y, z, material
	changeBlockFace terrain, "xn", "xp", x + 1, y, z, material
	changeBlockFace terrain, "yp", "yn", y, x, z, material
	changeBlockFace terrain, "yn", "yp", y + 1, x, z, material
	changeBlockFace terrain, "zp", "zn", z, x, y, material
	changeBlockFace terrain, "zn", "zp", z + 1, x, y, material
