module.exports = (quadrilaterals) ->
	output = []
	for quadrilateral in quadrilaterals
		output.push quadrilateral[0][0]
		output.push quadrilateral[1][0]

		output.push quadrilateral[0][0]
		output.push quadrilateral[1][1]

		output.push quadrilateral[0][1]
		output.push quadrilateral[1][1]

		output.push quadrilateral[0][1]
		output.push quadrilateral[1][0]
	output
