describe "optimiseTerrain", ->
	rewire = require "rewire"
	optimiseTerrain = undefined
	beforeEach -> optimiseTerrain = rewire "./optimiseTerrain"	

	describe "imports", ->
		it "optimisePlane", -> expect(optimiseTerrain.__get__ "optimisePlane").toBe require "./optimisePlane"

	describe "on calling", ->
		input = result = optimisePlane = undefined
		beforeEach ->
			input = 
				testPlaneA: "test plane a"
				testPlaneB: "test plane b"
				testPlaneC: "test plane c"
			optimisePlane = jasmine.createSpy "optimisePlane"
			optimiseTerrain.__set__ "optimisePlane", optimisePlane
		describe "when no plane is optimised", ->
			beforeEach -> result = optimiseTerrain input
			it "calls optimisePlane for all planes", ->
				expect(optimisePlane).toHaveBeenCalledWith "test plane a"
				expect(optimisePlane).toHaveBeenCalledWith "test plane b"
				expect(optimisePlane).toHaveBeenCalledWith "test plane c"
			it "returns falsy", -> expect(result).toBeFalsy()
			it "does not directly modify the input", -> expect(input).toEqual
				testPlaneA: "test plane a"
				testPlaneB: "test plane b"
				testPlaneC: "test plane c"
		describe "when at least one plane is optimised", ->
			beforeEach ->
				optimisePlane.and.callFake (plane) -> plane is "test plane b"
				result = optimiseTerrain input
			it "calls optimisePlane for all planes", ->
				expect(optimisePlane).toHaveBeenCalledWith "test plane a"
				expect(optimisePlane).toHaveBeenCalledWith "test plane b"
				expect(optimisePlane).toHaveBeenCalledWith "test plane c"
			it "returns truthy", -> expect(result).toBeTruthy()
			it "does not directly modify the input", -> expect(input).toEqual
				testPlaneA: "test plane a"
				testPlaneB: "test plane b"
				testPlaneC: "test plane c"
