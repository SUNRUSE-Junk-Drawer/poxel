describe "cutLayer", ->
	rewire = require "rewire"
	cutLayer = undefined
	beforeEach -> cutLayer = rewire "./cutLayer"

	describe "imports", ->
		it "cutQuadrilateralSet", -> expect(cutLayer.__get__ "cutQuadrilateralSet").toBe require "./cutQuadrilateralSet"

	describe "on calling", ->
		input = output = cutQuadrilateralSet = undefined
		beforeEach ->
			cutQuadrilateralSet = jasmine.createSpy "cutQuadrilateralSet"
			cutLayer.__set__ "cutQuadrilateralSet", cutQuadrilateralSet

			input = 
				materialA: "quadrilateralSetA"
				materialB: "quadrilateralSetB"
				materialC: "quadrilateralSetC"
		describe "when no cut is made", ->
			beforeEach ->
				cutQuadrilateralSet.and.callFake (quadrilateralSet, x, y) ->
					expect(quadrilateralSet is "quadrilateralSetA" or quadrilateralSet is "quadrilateralSetB" or quadrilateralSet is "quadrilateralSetC").toBeTruthy()
					expect(x).toEqual 5
					expect(y).toEqual 7
					false
				output = cutLayer input, 5, 7
			it "tries to cut every layer", ->
				expect(cutQuadrilateralSet).toHaveBeenCalledWith "quadrilateralSetA", 5, 7
				expect(cutQuadrilateralSet).toHaveBeenCalledWith "quadrilateralSetB", 5, 7
				expect(cutQuadrilateralSet).toHaveBeenCalledWith "quadrilateralSetC", 5, 7
			it "does not itself modify the input", -> expect(input).toEqual
				materialA: "quadrilateralSetA"
				materialB: "quadrilateralSetB"
				materialC: "quadrilateralSetC"
			it "returns falsy", -> expect(output).toBeFalsy()
		describe "when a cut is not made", ->
			beforeEach ->
				cutQuadrilateralSet.and.callFake (quadrilateralSet, x, y) ->
					expect(quadrilateralSet is "quadrilateralSetA" or quadrilateralSet is "quadrilateralSetB" or quadrilateralSet is "quadrilateralSetC").toBeTruthy()
					expect(x).toEqual 5
					expect(y).toEqual 7
					quadrilateralSet is "quadrilateralSetB"
				output = cutLayer input, 5, 7
			it "does not itself modify the input", -> expect(input).toEqual
				materialA: "quadrilateralSetA"
				materialB: "quadrilateralSetB"
				materialC: "quadrilateralSetC"
			it "returns truthy", -> expect(output).toBeTruthy()
