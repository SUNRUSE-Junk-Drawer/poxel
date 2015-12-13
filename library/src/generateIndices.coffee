module.exports = (quadrilaterals) ->
	output = []
	for index in [0...(quadrilaterals * 4)] by 4
		output.push index
		output.push index + 1
		output.push index + 2
		output.push index + 2
		output.push index + 3
		output.push index
	output
