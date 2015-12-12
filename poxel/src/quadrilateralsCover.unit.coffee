describe "quadrilateralsCover", ->
	rewire = require "rewire"
	quadrilateralsCover = undefined
	beforeEach -> quadrilateralsCover = rewire "./quadrilateralsCover"

	describe "imports", ->
		it "quadrilateralCovers", -> expect(quadrilateralsCover.__get__ "quadrilateralCovers").toBe require "./quadrilateralCovers"

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
			quadrilateralsCover.__set__ "quadrilateralCovers", quadrilateralCovers
		describe "when no quadrilaterals are hit", ->
			beforeEach -> output = quadrilateralsCover input, 5, 7

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
	
				output = quadrilateralsCover input, 5, 7

			it "does not modify the input", -> expect(input).toEqual [
				"test quadrilateral a"
				"test quadrilateral b"
				"test quadrilateral c"
			]

			it "returns truthy", -> expect(output).toBeTruthy()
