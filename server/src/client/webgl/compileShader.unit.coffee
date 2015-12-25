describe "compileShader", ->
	rewire = require "rewire"
	compileShader = undefined
	beforeEach -> compileShader = rewire "./compileShader"

	describe "imports", ->
		it "canvasContext", -> expect(compileShader.__get__ "canvasContext").toBe require "./../canvasContext"
		it "setState", -> expect(compileShader.__get__ "setState").toBe require "./../setState"

	describe "on calling", ->
		result = run = canvasContext = setState = undefined
		beforeEach ->
			canvasContext =
				instance:
					createShader: jasmine.createSpy "createShader"
					compileShader: jasmine.createSpy "compileShader"
					shaderSource: jasmine.createSpy "shaderSource"
					getShaderParameter: jasmine.createSpy "getShaderParameter"
					getShaderInfoLog: jasmine.createSpy "getShaderInfoLog"
					COMPILE_STATUS: "test compile status"

			canvasContext.instance.createShader.and.returnValue "test shader"
			canvasContext.instance.getShaderInfoLog.and.returnValue "test info log"
			compileShader.__set__ "canvasContext", canvasContext

			setState = jasmine.createSpy "setState"
			compileShader.__set__ "setState", setState

			run = -> result = compileShader "test shader type", "test shader source"

		describe "when compilation succeeds", ->
			beforeEach ->
				canvasContext.instance.getShaderParameter.and.returnValue true
			it "creates one shader", ->
				run()
				expect(canvasContext.instance.createShader.calls.count()).toEqual 1
				expect(canvasContext.instance.createShader).toHaveBeenCalledWith "test shader type"
			it "sets the source once", ->
				run()
				expect(canvasContext.instance.shaderSource.calls.count()).toEqual 1
				expect(canvasContext.instance.shaderSource).toHaveBeenCalledWith "test shader", "test shader source"
			it "then compiles the shader once", ->
				canvasContext.instance.compileShader.and.callFake ->
					expect(canvasContext.instance.shaderSource).toHaveBeenCalled()
				run()
				expect(canvasContext.instance.compileShader.calls.count()).toEqual 1
				expect(canvasContext.instance.compileShader).toHaveBeenCalledWith "test shader"
			it "then checks the compile status", ->
				canvasContext.instance.getShaderParameter.and.callFake ->
					expect(canvasContext.instance.compileShader).toHaveBeenCalled()
					true
				run()
				expect(canvasContext.instance.getShaderParameter.calls.count()).toEqual 1
				expect(canvasContext.instance.getShaderParameter).toHaveBeenCalledWith "test shader", "test compile status"				
			it "does not change the state", ->
				run()
				expect(setState).not.toHaveBeenCalled()
			it "does not get the compilation log", ->
				run()
				expect(canvasContext.instance.getShaderInfoLog).not.toHaveBeenCalled()
			it "returns the shader", ->
				run()
				expect(result).toEqual "test shader"
		describe "when compilation fails", ->
			beforeEach ->
				canvasContext.instance.getShaderParameter.and.returnValue false
			it "creates one shader", ->
				try run()
				expect(canvasContext.instance.createShader.calls.count()).toEqual 1
				expect(canvasContext.instance.createShader).toHaveBeenCalledWith "test shader type"
			it "then compiles the shader once", ->
				canvasContext.instance.compileShader.and.callFake ->
					expect(canvasContext.instance.shaderSource).toHaveBeenCalled()
				try run()
				expect(canvasContext.instance.compileShader.calls.count()).toEqual 1
				expect(canvasContext.instance.compileShader).toHaveBeenCalledWith "test shader"
			it "then checks the compile status", ->
				canvasContext.instance.getShaderParameter.and.callFake ->
					expect(canvasContext.instance.compileShader).toHaveBeenCalled()
					false
				try run()
				expect(canvasContext.instance.getShaderParameter.calls.count()).toEqual 1
				expect(canvasContext.instance.getShaderParameter).toHaveBeenCalledWith "test shader", "test compile status"				
			it "then gets the compilation log", ->
				canvasContext.instance.getShaderInfoLog.and.callFake ->
					expect(canvasContext.instance.compileShader).toHaveBeenCalled()
					"test info log"
				try run()
				expect(canvasContext.instance.getShaderInfoLog.calls.count()).toEqual 1
				expect(canvasContext.instance.getShaderInfoLog).toHaveBeenCalledWith "test shader"			
			it "sets the state", ->
				try run()
				expect(setState.calls.count()).toEqual 1
				expect(setState).toHaveBeenCalledWith "webGlCompilationError", "test info log"
			it "throws an exception", ->
				expect(run).toThrowError "Failed to compile a WebGL shader; test info log"
