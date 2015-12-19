materialCoveringInLayer = require "./materialCoveringInLayer"

module.exports = (terrain, x, y, z) ->
	if terrain.xn and terrain.xn[x + 1] and materialCoveringInLayer terrain.xn[x + 1], y, z then return true
	if terrain.xp and terrain.xp[x] and materialCoveringInLayer terrain.xp[x], y, z then return true
	if terrain.yn and terrain.yn[y + 1] and materialCoveringInLayer terrain.yn[y + 1], x, z then return true
	if terrain.yp and terrain.yp[y] and materialCoveringInLayer terrain.yp[y], x, z then return true
	if terrain.zn and terrain.zn[z + 1] and materialCoveringInLayer terrain.zn[z + 1], x, y then return true
	if terrain.zp and terrain.zp[z] and materialCoveringInLayer terrain.zp[z], x, y then return true
	false
