describe "quadrilateralCovers", ->
	quadrilateralCovers = require "./quadrilateralCovers"

	testFor = (description, x, y, hit) ->
		describe description, ->
			input = output = undefined
			beforeEach ->
				input = [[5, 8], [-6, 2]]
				output = quadrilateralCovers input, x, y
			it "does not modify the input", ->
				expect(input).toEqual [[5, 8], [-6, 2]]
			if hit
				it "returns truthy", -> expect(output).toBeTruthy()
			else
				it "returns falsy", -> expect(output).toBeFalsy()

	testFor "inside", 6, 0, true
	testFor "top left corner", 5, 1, true
	testFor "top right corner", 7, 1, true
	testFor "bottom left corner", 5, -6, true
	testFor "bottom right corner", 7, -6, true
	testFor "top border", 6, 1, true
	testFor "left border", 5, -1, true
	testFor "right border", 7, -1, true
	testFor "bottom border", 6, -6, true
	testFor "over top border", 6, 2, false
	testFor "over left border", 4, -1, false
	testFor "over right border", 8, -1, false
	testFor "over bottom border", 6, -7, false
	testFor "over top left corner", 4, 2, false
	testFor "over top right corner", 8, 2, false
	testFor "over bottom left corner", 4, -7, false
	testFor "over bottom right corner", 8, -7, false
	testFor "left of top left corner", 4, 1, false
	testFor "right of top right corner", 8, 1, false
	testFor "left of bottom left corner", 4, -6, false
	testFor "right of bottom right corner", 8, -6, false
	testFor "above top left corner", 5, 2, false
	testFor "above top right corner", 7, 2, false
	testFor "below bottom left corner", 5, -7, false
	testFor "below bottom right corner", 7, -7, false
