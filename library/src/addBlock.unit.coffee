describe "addBlock", ->
	rewire = require "rewire"
	addBlock = undefined
	beforeEach -> addBlock = rewire "./addBlock"
	
	describe "imports", ->
		it "changeBlockFace", -> expect(addBlock.__get__ "changeBlockFace").toBe require "./changeBlockFace"

	describe "on calling", ->
		changeBlockFace = undefined
		beforeEach ->
			changeBlockFace = jasmine.createSpy "changeBlockFace"
			addBlock.__set__ "changeBlockFace", changeBlockFace
			addBlock "testTerrain", 5, 7, 110, "testMaterial"
		it "makes a call for each face", ->
			expect(changeBlockFace.calls.count()).toEqual 6
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "xp", "xn", 5, 7, 110, "testMaterial"
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "xn", "xp", 6, 7, 110, "testMaterial"
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "yp", "yn", 7, 5, 110, "testMaterial"
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "yn", "yp", 8, 5, 110, "testMaterial"
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "zp", "zn", 110, 5, 7, "testMaterial"
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "zn", "zp", 111, 5, 7, "testMaterial"
