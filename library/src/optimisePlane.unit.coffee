describe "optimisePlane", ->
	rewire = require "rewire"
	optimisePlane = undefined
	beforeEach -> optimisePlane = rewire "./optimisePlane"	

	describe "imports", ->
		it "optimiseLayer", -> expect(optimisePlane.__get__ "optimiseLayer").toBe require "./optimiseLayer"

	describe "on calling", ->
		optimiseLayer = input = result = undefined
		beforeEach ->
			optimiseLayer = jasmine.createSpy "optimiseLayer"
			optimisePlane.__set__ "optimiseLayer", optimiseLayer
		describe "when the input is undefined", ->
			xit "returns falsy", ->
			xit "does not call optimiseLayer", ->
		describe "when the input is a plane", ->
			beforeEach ->
				input = 
					"-30": "test layer a"
					"-1": "test layer b"
					"0": "test layer c"
					"31": "test layer d"
					"75": "test layer e"
			describe "when no layers are optimised", ->
				beforeEach -> result = optimisePlane input
				it "returns falsy", -> expect(result).toBeFalsy()
				it "does not directly modify the input", -> expect(input).toEqual
					"-30": "test layer a"
					"-1": "test layer b"
					"0": "test layer c"
					"31": "test layer d"
					"75": "test layer e"
				it "calls optimiseLayer for all layers", -> 
					expect(optimiseLayer).toHaveBeenCalledWith "test layer a"
					expect(optimiseLayer).toHaveBeenCalledWith "test layer b"
					expect(optimiseLayer).toHaveBeenCalledWith "test layer c"
					expect(optimiseLayer).toHaveBeenCalledWith "test layer d"
					expect(optimiseLayer).toHaveBeenCalledWith "test layer e"
			describe "when at least one layer is optimised", ->
				beforeEach -> 
					optimiseLayer.and.callFake (layer) -> layer is "test layer c"
					result = optimisePlane input
				it "returns truthy", -> expect(result).toBeTruthy()
				it "does not directly modify the input", -> expect(input).toEqual
					"-30": "test layer a"
					"-1": "test layer b"
					"0": "test layer c"
					"31": "test layer d"
					"75": "test layer e"
				it "calls optimiseLayer for all layers", -> 
					expect(optimiseLayer).toHaveBeenCalledWith "test layer a"
					expect(optimiseLayer).toHaveBeenCalledWith "test layer b"
					expect(optimiseLayer).toHaveBeenCalledWith "test layer c"
					expect(optimiseLayer).toHaveBeenCalledWith "test layer d"
					expect(optimiseLayer).toHaveBeenCalledWith "test layer e"
