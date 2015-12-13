changeBlockFace = require "./changeBlockFace"

module.exports = (terrain, x, y, z, material) ->
	changeBlockFace terrain, "xn", "xp", x, y, z, material
	changeBlockFace terrain, "xp", "xn", x + 1, y, z, material
	changeBlockFace terrain, "yn", "yp", y, x, z, material
	changeBlockFace terrain, "yp", "yn", y + 1, x, z, material
	changeBlockFace terrain, "zn", "zp", z, x, y, material
	changeBlockFace terrain, "zp", "zn", z + 1, x, y, material
