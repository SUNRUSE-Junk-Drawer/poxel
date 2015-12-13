describe "subtractBlock", ->
	rewire = require "rewire"
	subtractBlock = undefined
	beforeEach -> subtractBlock = rewire "./subtractBlock"
	
	describe "imports", ->
		it "changeBlockFace", -> expect(subtractBlock.__get__ "changeBlockFace").toBe require "./changeBlockFace"

	describe "on calling", ->
		changeBlockFace = undefined
		beforeEach ->
			changeBlockFace = jasmine.createSpy "changeBlockFace"
			subtractBlock.__set__ "changeBlockFace", changeBlockFace
			subtractBlock "testTerrain", 5, 7, 110, "testMaterial"
		it "makes a call for each face", ->
			expect(changeBlockFace.calls.count()).toEqual 6
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "xn", "xp", 5, 7, 110, "testMaterial"
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "xp", "xn", 6, 7, 110, "testMaterial"
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "yn", "yp", 7, 5, 110, "testMaterial"
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "yp", "yn", 8, 5, 110, "testMaterial"
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "zn", "zp", 110, 5, 7, "testMaterial"
			expect(changeBlockFace).toHaveBeenCalledWith "testTerrain", "zp", "zn", 111, 5, 7, "testMaterial"
