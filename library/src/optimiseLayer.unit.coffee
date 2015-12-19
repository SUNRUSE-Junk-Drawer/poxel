describe "optimiseLayer", ->
	rewire = require "rewire"
	optimiseLayer = undefined
	beforeEach -> optimiseLayer = rewire "./optimiseLayer"

	describe "imports", ->
		it "optimiseQuadrilateralSet", -> expect(optimiseLayer.__get__ "optimiseQuadrilateralSet").toBe require "./optimiseQuadrilateralSet"

	describe "on calling", ->
		input = output = optimiseQuadrilateralSet = undefined
		beforeEach ->
			input = 
				testMaterialA: "testQuadrilateralSetA"
				testMaterialB: "testQuadrilateralSetB"
				testMaterialC: "testQuadrilateralSetC"
			optimiseQuadrilateralSet = jasmine.createSpy "optimiseQuadrilateralSet"
			optimiseLayer.__set__ "optimiseQuadrilateralSet", optimiseQuadrilateralSet
		describe "when no quadrilateral set is optimised", ->
			beforeEach -> 
				optimiseQuadrilateralSet.and.callFake (layer) ->
					expect(layer is "testQuadrilateralSetA" or layer is "testQuadrilateralSetB" or layer is "testQuadrilateralSetC").toBeTruthy()
				output = optimiseLayer input, 5, 7
			it "does not modify the input", -> expect(input).toEqual
				testMaterialA: "testQuadrilateralSetA"
				testMaterialB: "testQuadrilateralSetB"
				testMaterialC: "testQuadrilateralSetC"
			it "optimises every quadrilateral set", ->
				expect(optimiseQuadrilateralSet).toHaveBeenCalledWith "testQuadrilateralSetA"
				expect(optimiseQuadrilateralSet).toHaveBeenCalledWith "testQuadrilateralSetB"
				expect(optimiseQuadrilateralSet).toHaveBeenCalledWith "testQuadrilateralSetC"
			it "returns falsy", -> expect(output).toBeFalsy()
		describe "when at least one quadrilateral set is optimised", ->
			beforeEach -> 
				optimiseQuadrilateralSet.and.callFake (layer, x, y) ->
					expect(layer is "testQuadrilateralSetA" or layer is "testQuadrilateralSetB" or layer is "testQuadrilateralSetC").toBeTruthy()
					layer is "testQuadrilateralSetB"
				output = optimiseLayer input, 5, 7
			it "does not modify the input", -> expect(input).toEqual
				testMaterialA: "testQuadrilateralSetA"
				testMaterialB: "testQuadrilateralSetB"
				testMaterialC: "testQuadrilateralSetC"
			it "optimises every quadrilateral set", ->
				expect(optimiseQuadrilateralSet).toHaveBeenCalledWith "testQuadrilateralSetA"
				expect(optimiseQuadrilateralSet).toHaveBeenCalledWith "testQuadrilateralSetB"
				expect(optimiseQuadrilateralSet).toHaveBeenCalledWith "testQuadrilateralSetC"
			it "returns truthy", -> expect(output).toBeTruthy()
