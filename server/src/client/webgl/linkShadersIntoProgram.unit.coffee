describe "linkShadersIntoProgram", ->
	rewire = require "rewire"
	linkShadersIntoProgram = undefined
	beforeEach -> linkShadersIntoProgram = rewire "./linkShadersIntoProgram"
	describe "imports", ->
		it "canvasContext", -> expect(linkShadersIntoProgram.__get__ "canvasContext").toBe require "./../canvasContext"
		it "setState", -> expect(linkShadersIntoProgram.__get__ "setState").toBe require "./../setState"
	describe "on calling", ->
		run = result = canvasContext = setState = undefined
		beforeEach ->
			canvasContext = 
				instance:
					createProgram: jasmine.createSpy "createProgram"
					linkProgram: jasmine.createSpy "linkProgram"
					attachShader: jasmine.createSpy "attachShader"
					detachShader: jasmine.createSpy "detachShader"
					getProgramParameter: jasmine.createSpy "getProgramParameter"
					getProgramInfoLog: jasmine.createSpy "getProgramInfoLog"
					LINK_STATUS: "test link status"

			canvasContext.instance.createProgram.and.returnValue "test program"

			linkShadersIntoProgram.__set__ "canvasContext", canvasContext

			setState = jasmine.createSpy "setState"
			linkShadersIntoProgram.__set__ "setState", setState

			run = -> result = linkShadersIntoProgram "test vertex shader", "test fragment shader"

		describe "when linking is successful", ->
			beforeEach ->
				canvasContext.instance.getProgramParameter.and.returnValue true
			it "creates one program", ->
				run()
				expect(canvasContext.instance.createProgram.calls.count()).toEqual 1
			it "attaches the shaders", ->
				run()
				expect(canvasContext.instance.attachShader.calls.count()).toEqual 2
				expect(canvasContext.instance.attachShader).toHaveBeenCalledWith "test program", "test vertex shader"
				expect(canvasContext.instance.attachShader).toHaveBeenCalledWith "test program", "test fragment shader"
			it "then links the program", ->
				canvasContext.instance.linkProgram.and.callFake ->
					expect(canvasContext.instance.attachShader.calls.count()).toEqual 2
				run()
				expect(canvasContext.instance.linkProgram.calls.count()).toEqual 1
				expect(canvasContext.instance.linkProgram).toHaveBeenCalledWith "test program"
			it "then detaches the shaders", ->
				canvasContext.instance.detachShader.and.callFake ->
					expect(canvasContext.instance.linkProgram).toHaveBeenCalled()
				run()
				expect(canvasContext.instance.detachShader.calls.count()).toEqual 2
				expect(canvasContext.instance.detachShader).toHaveBeenCalledWith "test program", "test vertex shader"
				expect(canvasContext.instance.detachShader).toHaveBeenCalledWith "test program", "test fragment shader"
			it "then checks that the link succeeded", ->
				canvasContext.instance.getProgramParameter.and.callFake ->
					expect(canvasContext.instance.linkProgram).toHaveBeenCalled()
					true
				run()
				expect(canvasContext.instance.getProgramParameter.calls.count()).toEqual 1
				expect(canvasContext.instance.getProgramParameter).toHaveBeenCalledWith "test program", "test link status"
			it "does not get the log", ->
				run()
				expect(canvasContext.instance.getProgramInfoLog).not.toHaveBeenCalled()
			it "does not change the state", ->
				run()
				expect(setState).not.toHaveBeenCalled()
			it "returns the program", ->
				run()
				expect(result).toEqual "test program"
		describe "when linking is unsuccessful", ->
			beforeEach ->
				canvasContext.instance.getProgramParameter.and.returnValue false
				canvasContext.instance.getProgramInfoLog.and.returnValue "test program info log"
			it "creates one program", ->
				try
					run()
				expect(canvasContext.instance.createProgram.calls.count()).toEqual 1
			it "attaches the shaders", ->
				try
					run()
				expect(canvasContext.instance.attachShader.calls.count()).toEqual 2
				expect(canvasContext.instance.attachShader).toHaveBeenCalledWith "test program", "test vertex shader"
				expect(canvasContext.instance.attachShader).toHaveBeenCalledWith "test program", "test fragment shader"
			it "then links the program", ->
				canvasContext.instance.linkProgram.and.callFake ->
					expect(canvasContext.instance.attachShader.calls.count()).toEqual 2
				try
					run()
				expect(canvasContext.instance.linkProgram.calls.count()).toEqual 1
				expect(canvasContext.instance.linkProgram).toHaveBeenCalledWith "test program"
			it "then detaches the shaders", ->
				canvasContext.instance.detachShader.and.callFake ->
					expect(canvasContext.instance.linkProgram).toHaveBeenCalled()
				try				
					run()
				expect(canvasContext.instance.detachShader.calls.count()).toEqual 2
				expect(canvasContext.instance.detachShader).toHaveBeenCalledWith "test program", "test vertex shader"
				expect(canvasContext.instance.detachShader).toHaveBeenCalledWith "test program", "test fragment shader"
			it "then checks the link result", ->
				canvasContext.instance.getProgramParameter.and.callFake ->
					expect(canvasContext.instance.linkProgram).toHaveBeenCalled()
					false
				try
					run()
				expect(canvasContext.instance.getProgramParameter.calls.count()).toEqual 1
				expect(canvasContext.instance.getProgramParameter).toHaveBeenCalledWith "test program", "test link status"
			it "then gets the log", ->
				canvasContext.instance.getProgramInfoLog.and.callFake ->
					expect(canvasContext.instance.linkProgram).toHaveBeenCalled()
					"test program info log"
				try
					run()
				expect(canvasContext.instance.getProgramInfoLog.calls.count()).toEqual 1
				expect(canvasContext.instance.getProgramInfoLog).toHaveBeenCalledWith "test program"
			it "changes the state to \"webGlLinkingError\"", ->
				try
					run()
				expect(setState.calls.count()).toEqual 1
				expect(setState).toHaveBeenCalledWith "webGlLinkingError", "test program info log"
			it "throws an exception", ->
				expect(run).toThrowError "Failed to link a WebGL program; test program info log"
