describe "canvasSize", ->
	rewire = require "rewire"
	canvasSize = undefined
	beforeEach -> canvasSize = rewire "./canvasSize"
	describe "on calling", ->
		document = canvas = window = undefined
		beforeEach ->
			window = 
				addEventListener: jasmine.createSpy "addEventListener"
				innerWidth: 800
				innerHeight: 600
			canvasSize.__set__ "window", window

			canvas = 
				width: 640
				height: 480

			document = 
				getElementsByTagName: (name) -> switch name
					when "canvas" then [canvas]
					else []
			canvasSize.__set__ "document", document

			canvasSize()
		it "sizes the canvas to fill the window", ->
			expect(canvas.width).toEqual 800
			expect(canvas.height).toEqual 600
		it "listens for window resizes", ->
			expect(window.addEventListener.calls.count()).toEqual 1
			expect(window.addEventListener).toHaveBeenCalledWith "resize", jasmine.any Function
		describe "when the window resizes", ->
			beforeEach ->
				window.innerWidth = 1280
				window.innerHeight = 1024
				(window.addEventListener.calls.argsFor 0)[1]()
			it "does not listen for further window resizes", ->
				expect(window.addEventListener.calls.count()).toEqual 1
			it "resizes the canvas to fill the window", ->
				expect(canvas.width).toEqual 1280
				expect(canvas.height).toEqual 1024
