describe "generateIndices", ->
	generateIndices = require "./generateIndices"
	output = undefined
	beforeEach ->
		output = generateIndices 3
	it "returns the expected output", -> expect(output).toEqual [
		0, 1, 2
		2, 3, 0

		4, 5, 6
		6, 7, 4

		8, 9, 10
		10, 11, 8
	]
