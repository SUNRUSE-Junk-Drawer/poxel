describe "materialCovering", ->
	rewire = require "rewire"
	materialCovering = undefined
	beforeEach -> materialCovering = rewire "./materialCovering"

	describe "imports", ->
		it "quadrilateralsCover", -> expect(materialCovering.__get__ "quadrilateralsCover").toBe require "./quadrilateralsCover"

	describe "on calling", ->
		input = output = quadrilateralsCover = undefined
		beforeEach ->
			input = 
				testMaterialA: "testLayerA"
				testMaterialB: "testLayerB"
				testMaterialC: "testLayerC"
			quadrilateralsCover = jasmine.createSpy "quadrilateralsCover"
			materialCovering.__set__ "quadrilateralsCover", quadrilateralsCover
		describe "when no quadrilateral covers the point", ->
			beforeEach -> 
				quadrilateralsCover.and.callFake (layer, x, y) ->
					expect(layer is "testLayerA" or layer is "testLayerB" or layer is "testLayerC").toBeTruthy()
					expect(x).toEqual 5
					expect(y).toEqual 7
				output = materialCovering input, 5, 7
			it "does not modify the input", -> expect(input).toEqual
				testMaterialA: "testLayerA"
				testMaterialB: "testLayerB"
				testMaterialC: "testLayerC"
			it "returns null", -> expect(output).toBeNull()
		describe "when no quadrilateral covers the point", ->
			beforeEach -> 
				quadrilateralsCover.and.callFake (layer, x, y) ->
					expect(layer is "testLayerA" or layer is "testLayerB" or layer is "testLayerC").toBeTruthy()
					expect(x).toEqual 5
					expect(y).toEqual 7
					layer is "testLayerB"
				output = materialCovering input, 5, 7
			it "does not modify the input", -> expect(input).toEqual
				testMaterialA: "testLayerA"
				testMaterialB: "testLayerB"
				testMaterialC: "testLayerC"
			it "returns the covered material", -> expect(output).toEqual "testMaterialB"
