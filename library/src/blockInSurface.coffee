materialCoveringInLayer = require "./materialCoveringInLayer"

module.exports = (terrain, x, y, z) ->
	if terrain.xp and terrain.xp[x + 1] and materialCoveringInLayer terrain.xp[x + 1], y, z then return true
	if terrain.xn and terrain.xn[x] and materialCoveringInLayer terrain.xn[x], y, z then return true
	if terrain.yp and terrain.yp[y + 1] and materialCoveringInLayer terrain.yp[y + 1], x, z then return true
	if terrain.yn and terrain.yn[y] and materialCoveringInLayer terrain.yn[y], x, z then return true
	if terrain.zp and terrain.zp[z + 1] and materialCoveringInLayer terrain.zp[z + 1], x, y then return true
	if terrain.zn and terrain.zn[z] and materialCoveringInLayer terrain.zn[z], x, y then return true
	false
