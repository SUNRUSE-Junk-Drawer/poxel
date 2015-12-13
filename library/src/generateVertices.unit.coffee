describe "generateVertices", ->
	generateVertices = require "./generateVertices"
	input = output = undefined
	beforeEach ->
		input = [
			[[-15, 20], [3, 7]]
			[[24, 27], [8, 12]]
		]
		output = generateVertices input
	it "does not modify the input", -> expect(input).toEqual [
		[[-15, 20], [3, 7]]
		[[24, 27], [8, 12]]
	]
	it "returns the expected output", -> expect(output).toEqual [
		-15, 3
		-15, 7
		20, 7
		20, 3

		24, 8
		24, 12
		27, 12
		27, 8
	]
