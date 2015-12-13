describe "quadrilateralSetCovers", ->
	rewire = require "rewire"
	quadrilateralSetCovers = undefined
	beforeEach -> quadrilateralSetCovers = rewire "./quadrilateralSetCovers"

	describe "imports", ->
		it "quadrilateralCovers", -> expect(quadrilateralSetCovers.__get__ "quadrilateralCovers").toBe require "./quadrilateralCovers"

	describe "on calling", ->
		input = output = quadrilateralCovers = undefined
		beforeEach ->
			input = [
				"test quadrilateral a"
				"test quadrilateral b"
				"test quadrilateral c"
			]

			quadrilateralCovers = jasmine.createSpy "quadrilateralCovers"
			quadrilateralCovers.and.callFake (quadrilateral, x, y) ->
				expect(x).toEqual 5
				expect(y).toEqual 7
				expect(quadrilateral is "test quadrilateral a" or quadrilateral is "test quadrilateral b" or quadrilateral is "test quadrilateral c").toBeTruthy()
			quadrilateralSetCovers.__set__ "quadrilateralCovers", quadrilateralCovers
		describe "when no quadrilaterals are hit", ->
			beforeEach -> output = quadrilateralSetCovers input, 5, 7

			it "does not modify the input", -> expect(input).toEqual [
				"test quadrilateral a"
				"test quadrilateral b"
				"test quadrilateral c"
			]

			it "returns falsy", -> expect(output).toBeFalsy()

		describe "when a quadrilateral is hit", ->
			beforeEach -> 
				quadrilateralCovers.and.callFake (quadrilateral, x, y) ->
					expect(x).toEqual 5
					expect(y).toEqual 7
					expect(quadrilateral is "test quadrilateral a" or quadrilateral is "test quadrilateral b" or quadrilateral is "test quadrilateral c").toBeTruthy()
					quadrilateral is "test quadrilateral b"
	
				output = quadrilateralSetCovers input, 5, 7

			it "does not modify the input", -> expect(input).toEqual [
				"test quadrilateral a"
				"test quadrilateral b"
				"test quadrilateral c"
			]

			it "returns truthy", -> expect(output).toBeTruthy()
