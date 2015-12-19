describe "materialCoveringInLayer", ->
	rewire = require "rewire"
	materialCoveringInLayer = undefined
	beforeEach -> materialCoveringInLayer = rewire "./materialCoveringInLayer"

	describe "imports", ->
		it "quadrilateralSetCovers", -> expect(materialCoveringInLayer.__get__ "quadrilateralSetCovers").toBe require "./quadrilateralSetCovers"

	describe "on calling", ->
		input = output = quadrilateralSetCovers = undefined
		beforeEach ->
			input = 
				testMaterialA: "testLayerA"
				testMaterialB: "testLayerB"
				testMaterialC: "testLayerC"
			quadrilateralSetCovers = jasmine.createSpy "quadrilateralSetCovers"
			materialCoveringInLayer.__set__ "quadrilateralSetCovers", quadrilateralSetCovers
		describe "when no quadrilateral covers the point", ->
			beforeEach -> 
				quadrilateralSetCovers.and.callFake (layer, x, y) ->
					expect(layer is "testLayerA" or layer is "testLayerB" or layer is "testLayerC").toBeTruthy()
					expect(x).toEqual 5
					expect(y).toEqual 7
				output = materialCoveringInLayer input, 5, 7
			it "does not modify the input", -> expect(input).toEqual
				testMaterialA: "testLayerA"
				testMaterialB: "testLayerB"
				testMaterialC: "testLayerC"
			it "returns null", -> expect(output).toBeNull()
		describe "when no quadrilateral covers the point", ->
			beforeEach -> 
				quadrilateralSetCovers.and.callFake (layer, x, y) ->
					expect(layer is "testLayerA" or layer is "testLayerB" or layer is "testLayerC").toBeTruthy()
					expect(x).toEqual 5
					expect(y).toEqual 7
					layer is "testLayerB"
				output = materialCoveringInLayer input, 5, 7
			it "does not modify the input", -> expect(input).toEqual
				testMaterialA: "testLayerA"
				testMaterialB: "testLayerB"
				testMaterialC: "testLayerC"
			it "returns the covered material", -> expect(output).toEqual "testMaterialB"
