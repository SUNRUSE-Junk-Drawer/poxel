describe "changeBlockFace", ->
	rewire = require "rewire"
	changeBlockFace = undefined
	beforeEach -> changeBlockFace = rewire "./changeBlockFace"
	
	describe "imports", ->
		it "cutTerrain", -> expect(changeBlockFace.__get__ "cutTerrain").toBe require "./cutTerrain"
		it "add", -> expect(changeBlockFace.__get__ "add").toBe require "./add"

	describe "on calling", ->
		cutTerrain = add = undefined
		beforeEach ->
			add = jasmine.createSpy "add"
			changeBlockFace.__set__ "add", add
			cutTerrain = jasmine.createSpy "cutTerrain"
			changeBlockFace.__set__ "cutTerrain", cutTerrain
			
		describe "when there is no face to cut out", ->
			beforeEach ->
				cutTerrain.and.returnValue false
				changeBlockFace "testTerrain", "testRemovalFacingDirection", "testAdditionFacingDirection", 140, 5, 7, "testMaterial"
			it "cuts the face", ->
				expect(cutTerrain.calls.count()).toEqual 1
				expect(cutTerrain).toHaveBeenCalledWith "testTerrain", "testRemovalFacingDirection", 140, 5, 7
			it "adds one replacement face", ->						
				expect(add.calls.count()).toEqual 1
				expect(add).toHaveBeenCalledWith "testTerrain", "testAdditionFacingDirection", 140, "testMaterial", 5, 6, 7, 8
		describe "when there is a face to cut out", ->
			beforeEach ->
				cutTerrain.and.returnValue true
				changeBlockFace "testTerrain", "testRemovalFacingDirection", "testAdditionFacingDirection", 140, 5, 7, "testMaterial"
			it "cuts the face", ->
				expect(cutTerrain.calls.count()).toEqual 1
				expect(cutTerrain).toHaveBeenCalledWith "testTerrain", "testRemovalFacingDirection", 140, 5, 7
			it "does not add any faces", ->						
				expect(add).not.toHaveBeenCalled()
