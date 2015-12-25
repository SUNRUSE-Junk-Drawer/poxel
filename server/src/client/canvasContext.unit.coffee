describe "canvasContext", ->
	rewire = require "rewire"
	canvasContext = undefined
	beforeEach -> canvasContext = rewire "./canvasContext"

	describe "imports", ->
		it "setState", -> expect(canvasContext.__get__ "setState").toBe require "./setState"

	describe "on calling", ->
		setState = document = canvas = window = undefined
		beforeEach ->
			window = 
				addEventListener: jasmine.createSpy "addEventListener"
				innerWidth: 800
				innerHeight: 600
			canvasContext.__set__ "window", window

			setState = jasmine.createSpy "setState"
			canvasContext.__set__ "setState", setState

			canvas = 
				getContext: jasmine.createSpy "getContext"

			document = 
				getElementsByTagName: (name) -> switch name
					when "canvas" then [canvas]
					else []
			canvasContext.__set__ "document", document
		describe "when no context is available", ->
			it "attempts to get the context once", ->
				try
					canvasContext()
				expect(canvas.getContext.calls.count()).toEqual 1
				expect(canvas.getContext).toHaveBeenCalledWith "webgl"
			it "updates the state", ->
				try
					canvasContext()
				expect(setState.calls.count()).toEqual 1
				expect(setState).toHaveBeenCalledWith "noWebGl"
			it "throws an exception", ->
				expect(canvasContext).toThrowError "No WebGL context is available"
		describe "when a context is available", ->
			beforeEach ->
				canvas.getContext.and.returnValue "test context"
				canvasContext()
			it "attempts to get the context once", ->
				expect(canvas.getContext.calls.count()).toEqual 1
				expect(canvas.getContext).toHaveBeenCalledWith "webgl"
			it "exports the context", ->
				expect(canvasContext.instance).toEqual "test context"
			it "does not update the state", ->
				expect(setState).not.toHaveBeenCalled()
