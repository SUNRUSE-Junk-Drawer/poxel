describe "cutTerrain", ->
	rewire = require "rewire"
	cutTerrain = undefined
	beforeEach -> cutTerrain = rewire "./cutTerrain"
	describe "imports", ->
		it "cutLayer", -> expect(cutTerrain.__get__ "cutLayer").toBe require "./cutLayer"

	describe "on calling", ->
		cutLayer = input = output = undefined
		beforeEach ->
			cutLayer = jasmine.createSpy "cutLayer"
			cutTerrain.__set__ "cutLayer", cutLayer
		describe "when the specified layer is zero", ->
			describe "when the specified facing direction does not exist", ->
				beforeEach ->
					input = 
						facingDirectionA:
							"-110": "layerAA"
							"0": "layerAB"
							"75": "layerAC"
					output = cutTerrain input, "facingDirectionB", 0, 5, 7
				it "does not cut any layers", -> expect(cutLayer).not.toHaveBeenCalled()
				it "does not modify the terrain itself", -> expect(input).toEqual
					facingDirectionA:
						"-110": "layerAA"
						"0": "layerAB"
						"75": "layerAC"
				it "returns falsy", -> expect(output).toBeFalsy()
			describe "when the specified layer does not exist in the specified facing direction", ->
				beforeEach ->
					input = 
						facingDirectionA:
							"-110": "layerAA"
							"0": "layerAB"
							"75": "layerAC"
						facingDirectionB:
							"-110": "layerBA"
							"75": "layerBC"
					output = cutTerrain input, "facingDirectionB", 0, 5, 7
				it "does not cut any layers", -> expect(cutLayer).not.toHaveBeenCalled()
				it "does not modify the terrain itself", -> expect(input).toEqual
					facingDirectionA:
						"-110": "layerAA"
						"0": "layerAB"
						"75": "layerAC"
					facingDirectionB:
						"-110": "layerBA"
						"75": "layerBC"
				it "returns falsy", -> expect(output).toBeFalsy()
			describe "when the specified layer exists in the specified facing direction", ->
				beforeEach ->
					input = 
						facingDirectionA:
							"-110": "layerAA"
							"0": "layerAB"
							"75": "layerAC"
						facingDirectionB:
							"-110": "layerBA"
							"0": "layerBB"
							"75": "layerBC"
				describe "when a cut is made", ->
					beforeEach ->
						cutLayer.and.returnValue true
						output = cutTerrain input, "facingDirectionB", 0, 5, 7
					it "cuts the specified layer", ->
						expect(cutLayer.calls.count()).toEqual 1
						expect(cutLayer).toHaveBeenCalledWith "layerBB", 5, 7
					it "does not modify the terrain itself", ->
						expect(input).toEqual 
							facingDirectionA:
								"-110": "layerAA"
								"0": "layerAB"
								"75": "layerAC"
							facingDirectionB:
								"-110": "layerBA"
								"0": "layerBB"
								"75": "layerBC"
					it "returns truthy", -> expect(output).toBeTruthy()
				describe "when no cut is made", ->
					beforeEach ->
						cutLayer.and.returnValue false
						output = cutTerrain input, "facingDirectionB", 0, 5, 7
					it "cuts the specified layer", ->
						expect(cutLayer.calls.count()).toEqual 1
						expect(cutLayer).toHaveBeenCalledWith "layerBB", 5, 7
					it "does not modify the terrain itself", ->
						expect(input).toEqual 
							facingDirectionA:
								"-110": "layerAA"
								"0": "layerAB"
								"75": "layerAC"
							facingDirectionB:
								"-110": "layerBA"
								"0": "layerBB"
								"75": "layerBC"
					it "returns false", -> expect(output).toBeFalsy()
		describe "when the specified layer is positive", ->
			describe "when the specified facing direction does not exist", ->
				beforeEach ->
					input = 
						facingDirectionA:
							"-110": "layerAA"
							"0": "layerAB"
							"75": "layerAC"
					output = cutTerrain input, "facingDirectionB", 75, 5, 7
				it "does not cut any layers", -> expect(cutLayer).not.toHaveBeenCalled()
				it "does not modify the terrain itself", -> expect(input).toEqual
					facingDirectionA:
						"-110": "layerAA"
						"0": "layerAB"
						"75": "layerAC"
				it "returns falsy", -> expect(output).toBeFalsy()
			describe "when the specified layer does not exist in the specified facing direction", ->
				beforeEach ->
					input = 
						facingDirectionA:
							"-110": "layerAA"
							"0": "layerAB"
							"75": "layerAC"
						facingDirectionB:
							"-110": "layerBA"
							"0": "layerBC"
					output = cutTerrain input, "facingDirectionB", 75, 5, 7
				it "does not cut any layers", -> expect(cutLayer).not.toHaveBeenCalled()
				it "does not modify the terrain itself", -> expect(input).toEqual
					facingDirectionA:
						"-110": "layerAA"
						"0": "layerAB"
						"75": "layerAC"
					facingDirectionB:
						"-110": "layerBA"
						"0": "layerBC"
				it "returns falsy", -> expect(output).toBeFalsy()
			describe "when the specified layer exists in the specified facing direction", ->
				beforeEach ->
					input = 
						facingDirectionA:
							"-110": "layerAA"
							"0": "layerAB"
							"75": "layerAC"
						facingDirectionB:
							"-110": "layerBA"
							"75": "layerBB"
							"0": "layerBC"
				describe "when a cut is made", ->
					beforeEach ->
						cutLayer.and.returnValue true
						output = cutTerrain input, "facingDirectionB", 75, 5, 7
					it "cuts the specified layer", ->
						expect(cutLayer.calls.count()).toEqual 1
						expect(cutLayer).toHaveBeenCalledWith "layerBB", 5, 7
					it "does not modify the terrain itself", ->
						expect(input).toEqual 
							facingDirectionA:
								"-110": "layerAA"
								"0": "layerAB"
								"75": "layerAC"
							facingDirectionB:
								"-110": "layerBA"
								"75": "layerBB"
								"0": "layerBC"
					it "returns truthy", -> expect(output).toBeTruthy()
				describe "when no cut is made", ->
					beforeEach ->
						cutLayer.and.returnValue false
						output = cutTerrain input, "facingDirectionB", 75, 5, 7
					it "cuts the specified layer", ->
						expect(cutLayer.calls.count()).toEqual 1
						expect(cutLayer).toHaveBeenCalledWith "layerBB", 5, 7
					it "does not modify the terrain itself", ->
						expect(input).toEqual 
							facingDirectionA:
								"-110": "layerAA"
								"0": "layerAB"
								"75": "layerAC"
							facingDirectionB:
								"-110": "layerBA"
								"75": "layerBB"
								"0": "layerBC"
					it "returns false", -> expect(output).toBeFalsy()
		describe "when the specified layer is negative", ->
			describe "when the specified facing direction does not exist", ->
				beforeEach ->
					input = 
						facingDirectionA:
							"-110": "layerAA"
							"0": "layerAB"
							"75": "layerAC"
					output = cutTerrain input, "facingDirectionB", -110, 5, 7
				it "does not cut any layers", -> expect(cutLayer).not.toHaveBeenCalled()
				it "does not modify the terrain itself", -> expect(input).toEqual
					facingDirectionA:
						"-110": "layerAA"
						"0": "layerAB"
						"75": "layerAC"
				it "returns falsy", -> expect(output).toBeFalsy()
			describe "when the specified layer does not exist in the specified facing direction", ->
				beforeEach ->
					input = 
						facingDirectionA:
							"-110": "layerAA"
							"0": "layerAB"
							"75": "layerAC"
						facingDirectionB:
							"0": "layerBA"
							"75": "layerBC"
					output = cutTerrain input, "facingDirectionB", -110, 5, 7
				it "does not cut any layers", -> expect(cutLayer).not.toHaveBeenCalled()
				it "does not modify the terrain itself", -> expect(input).toEqual
					facingDirectionA:
						"-110": "layerAA"
						"0": "layerAB"
						"75": "layerAC"
					facingDirectionB:
						"0": "layerBA"
						"75": "layerBC"
				it "returns falsy", -> expect(output).toBeFalsy()
			describe "when the specified layer exists in the specified facing direction", ->
				beforeEach ->
					input = 
						facingDirectionA:
							"-110": "layerAA"
							"0": "layerAB"
							"75": "layerAC"
						facingDirectionB:
							"0": "layerBA"
							"-110": "layerBB"
							"75": "layerBC"
				describe "when a cut is made", ->
					beforeEach ->
						cutLayer.and.returnValue true
						output = cutTerrain input, "facingDirectionB", -110, 5, 7
					it "cuts the specified layer", ->
						expect(cutLayer.calls.count()).toEqual 1
						expect(cutLayer).toHaveBeenCalledWith "layerBB", 5, 7
					it "does not modify the terrain itself", ->
						expect(input).toEqual 
							facingDirectionA:
								"-110": "layerAA"
								"0": "layerAB"
								"75": "layerAC"
							facingDirectionB:
								"0": "layerBA"
								"-110": "layerBB"
								"75": "layerBC"
					it "returns truthy", -> expect(output).toBeTruthy()
				describe "when no cut is made", ->
					beforeEach ->
						cutLayer.and.returnValue false
						output = cutTerrain input, "facingDirectionB", -110, 5, 7
					it "cuts the specified layer", ->
						expect(cutLayer.calls.count()).toEqual 1
						expect(cutLayer).toHaveBeenCalledWith "layerBB", 5, 7
					it "does not modify the terrain itself", ->
						expect(input).toEqual 
							facingDirectionA:
								"-110": "layerAA"
								"0": "layerAB"
								"75": "layerAC"
							facingDirectionB:
								"0": "layerBA"
								"-110": "layerBB"
								"75": "layerBC"
					it "returns false", -> expect(output).toBeFalsy()
