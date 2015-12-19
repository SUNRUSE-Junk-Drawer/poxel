vertexConverters = 
	xn: (layer, x, y) -> [layer, x, -y]
	xp: (layer, x, y) -> [layer, x, -y]
	yn: (layer, x, y) -> [x, layer, -y]
	yp: (layer, x, y) -> [x, layer, -y]
	zn: (layer, x, y) -> [x, y, -layer]
	zp: (layer, x, y) -> [x, y, -layer]

module.exports = (input) ->
	output = "s off\nvn -1 0 0\nvn 0 0 -1\nvn 0 1 0\nvn 1 0 0\nvn 0 0 1\nvn 0 -1 0"

	for facingDirection, layers of input
		for layer, materials of layers
			for material, quadrilateralSet of materials
				for quadrilateral in quadrilateralSet
					output += "\nv " + ((vertexConverters[facingDirection] layer, quadrilateral[0][0], quadrilateral[1][0]).join " ")
					output += "\nv " + ((vertexConverters[facingDirection] layer, quadrilateral[0][0], quadrilateral[1][1]).join " ")
					output += "\nv " + ((vertexConverters[facingDirection] layer, quadrilateral[0][1], quadrilateral[1][1]).join " ")
					output += "\nv " + ((vertexConverters[facingDirection] layer, quadrilateral[0][1], quadrilateral[1][0]).join " ")
					output += "\nvt " + quadrilateral[0][0] + " " + quadrilateral[1][0]
					output += "\nvt " + quadrilateral[0][0] + " " + quadrilateral[1][1]
					output += "\nvt " + quadrilateral[0][1] + " " + quadrilateral[1][1]
					output += "\nvt " + quadrilateral[0][1] + " " + quadrilateral[1][0]
					output += "\nusemtl " + material
					switch facingDirection
						when "xn" then output += "\nf -1/-2/1 -2/-3/1 -3/-4/1 -4/-1/1"
						when "zn" then output += "\nf -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2"
						when "yp" then output += "\nf -1/-1/3 -2/-2/3 -3/-3/3 -4/-4/3"
						when "xp" then output += "\nf -4/-4/4 -3/-1/4 -2/-2/4 -1/-3/4"
						when "zp" then output += "\nf -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5"
						else           output += "\nf -4/-3/6 -3/-4/6 -2/-1/6 -1/-2/6"
	output
