describe "compileProgram", ->
	rewire = require "rewire"
	compileProgram = undefined
	beforeEach -> compileProgram = rewire "./compileProgram"

	describe "imports", ->
		it "compileShader", -> expect(compileProgram.__get__ "compileShader").toBe require "./compileShader"
		it "linkShadersIntoProgram", -> expect(compileProgram.__get__ "linkShadersIntoProgram").toBe require "./linkShadersIntoProgram"
		it "canvasContext", -> expect(compileProgram.__get__ "canvasContext").toBe require "./../canvasContext"

	describe "on calling", ->
		run = compileShader = linkShadersIntoProgram = canvasContext = result = undefined
		beforeEach ->
			canvasContext = 
				instance:
					VERTEX_SHADER: "test vertex shader"
					FRAGMENT_SHADER: "test fragment shader"
					deleteShader: jasmine.createSpy "deleteShader"
			compileProgram.__set__ "canvasContext", canvasContext

			compileShader = jasmine.createSpy "compileShader"
			compileShader.and.callFake (type, source) -> "compiled from - " + type + " - " + source
			compileProgram.__set__ "compileShader", compileShader

			linkShadersIntoProgram = jasmine.createSpy "linkShadersIntoProgram"
			linkShadersIntoProgram.and.callFake (vertex, fragment) -> "linked from = " + vertex + " = " + fragment
			compileProgram.__set__ "linkShadersIntoProgram", linkShadersIntoProgram

			run = -> result = compileProgram "test vertex shader source", "test fragment shader source"
		it "compiles two shaders", -> 
			run()
			expect(compileShader.calls.count()).toEqual 2
		it "compiles the vertex shader once", ->
			run()
			expect(compileShader).toHaveBeenCalledWith "test vertex shader", "test vertex shader source"
		it "compiles the fragment shader once", ->
			run()
			expect(compileShader).toHaveBeenCalledWith "test fragment shader", "test fragment shader source"
		it "then links the shaders into a program once", ->
			run()
			expect(linkShadersIntoProgram.calls.count()).toEqual 1
			expect(linkShadersIntoProgram).toHaveBeenCalledWith "compiled from - test vertex shader - test vertex shader source", "compiled from - test fragment shader - test fragment shader source"
		it "then deletes the shaders", ->
			canvasContext.instance.deleteShader.and.callFake ->
				expect(linkShadersIntoProgram).toHaveBeenCalled()
			run()
			expect(canvasContext.instance.deleteShader.calls.count()).toEqual 2
		it "then deletes the vertex shader", ->
			run()
			expect(canvasContext.instance.deleteShader).toHaveBeenCalledWith "compiled from - test vertex shader - test vertex shader source"
		it "then deletes the fragment shader", ->
			run()
			expect(canvasContext.instance.deleteShader).toHaveBeenCalledWith "compiled from - test fragment shader - test fragment shader source"
		it "returns the program", ->
			run()
			expect(result).toEqual "linked from = compiled from - test vertex shader - test vertex shader source = compiled from - test fragment shader - test fragment shader source"
