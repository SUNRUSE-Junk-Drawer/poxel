module.exports = (quadrilateral, x, y) -> switch
	when x < quadrilateral[0][0] then false
	when y < quadrilateral[1][0] then false
	when x >= quadrilateral[0][1] then false
	when y >= quadrilateral[1][1] then false
	else true
