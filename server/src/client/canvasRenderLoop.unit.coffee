describe "canvasRenderLoop", ->
	rewire = require "rewire"
	canvasRenderLoop = undefined
	beforeEach -> canvasRenderLoop = rewire "./canvasRenderLoop"

	describe "imports", ->
		it "render", -> expect(canvasRenderLoop.__get__ "render").toBe require "./render"

	describe "on calling", ->
		window = render = undefined
		beforeEach ->
			window = 
				requestAnimationFrame: jasmine.createSpy "requestAnimationFrame"
			canvasRenderLoop.__set__ "window", window

			render = jasmine.createSpy "render"
			canvasRenderLoop.__set__ "render", render

			canvasRenderLoop()
		it "registers a callback", ->
			expect(window.requestAnimationFrame.calls.count()).toEqual 1
			expect(window.requestAnimationFrame).toHaveBeenCalledWith jasmine.any Function
		it "renders once", ->
			expect(window.requestAnimationFrame.calls.count()).toEqual 1
		describe "when the next frame comes", ->
			beforeEach ->
				(window.requestAnimationFrame.calls.argsFor 0)[0]()
			it "registers a callback", ->
				expect(window.requestAnimationFrame.calls.count()).toEqual 2
			it "renders once", ->
				expect(window.requestAnimationFrame.calls.count()).toEqual 2
			describe "when the next frame comes", ->
				beforeEach ->
					(window.requestAnimationFrame.calls.argsFor 1)[0]()
				it "registers a callback", ->
					expect(window.requestAnimationFrame.calls.count()).toEqual 3
				it "renders once", ->
					expect(window.requestAnimationFrame.calls.count()).toEqual 3
				describe "when the next frame comes", ->
					beforeEach ->
						(window.requestAnimationFrame.calls.argsFor 2)[0]()
					it "registers a callback", ->
						expect(window.requestAnimationFrame.calls.count()).toEqual 4
					it "renders once", ->
						expect(window.requestAnimationFrame.calls.count()).toEqual 4
