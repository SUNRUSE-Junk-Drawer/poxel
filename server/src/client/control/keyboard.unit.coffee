describe "keyboard", ->
	rewire = require "rewire"
	keyboard = undefined
	beforeEach -> keyboard = rewire "./keyboard"

	describe "imports", ->
		it "controller", -> expect(keyboard.__get__ "controller").toBe require "./controller"		
		it "keyboardMappings", -> expect(keyboard.__get__ "keyboardMappings").toBe require "./keyboardMappings"

	describe "on calling", ->
		controller = keyboardMappings = window = raiseEvent = undefined
		beforeEach ->
			window = 
				addEventListener: jasmine.createSpy "addEventListener"
			keyboard.__set__ "window", window

			controller = 
				mappedKeyA: 0.3
				mappedKeyB: 0.8
				mappedKeyC: 0.4
				unmappedKey: 0.9
			keyboard.__set__ "controller", controller

			keyboardMappings = 
				"27": "mappedKeyA"
				"50": "mappedKeyB"
				"60": "mappedKeyC"
			keyboard.__set__ "keyboardMappings", keyboardMappings

			raiseEvent = (name, parameter) -> (args[1] for args in window.addEventListener.calls.allArgs() when args[0] is name)[0] parameter
			
			keyboard()
		it "does not modify the keyboard mappings", ->
			expect(keyboardMappings).toEqual 
				"27": "mappedKeyA"
				"50": "mappedKeyB"
				"60": "mappedKeyC"
		it "does not modify the controller", ->
			expect(controller.mappedKeyA).toEqual 0.3
			expect(controller.mappedKeyB).toEqual 0.8
			expect(controller.mappedKeyC).toEqual 0.4
			expect(controller.unmappedKey).toEqual 0.9
		it "registers two event handlers", ->
			expect(window.addEventListener.calls.count()).toEqual 2
		it "registers a key-up handler", ->
			expect(window.addEventListener).toHaveBeenCalledWith "keyup", jasmine.any Function
		it "registers a key-down handler", ->
			expect(window.addEventListener).toHaveBeenCalledWith "keydown", jasmine.any Function
		describe "when a key is pushed down", ->
			describe "and no mapping exists", ->
				beforeEach -> raiseEvent "keydown", 
					keyCode: 51
				it "does not modify the keyboard mappings", ->
					expect(keyboardMappings).toEqual
						"27": "mappedKeyA"
						"50": "mappedKeyB"
						"60": "mappedKeyC"
				it "does not modify the controller", ->
					expect(controller.mappedKeyA).toEqual 0.3
					expect(controller.mappedKeyB).toEqual 0.8
					expect(controller.mappedKeyC).toEqual 0.4
					expect(controller.unmappedKey).toEqual 0.9
				it "does not register any further event handlers", ->
					expect(window.addEventListener.calls.count()).toEqual 2
			describe "and a mapping exists", ->
				beforeEach -> raiseEvent "keydown", 
					keyCode: 50
				it "does not modify the keyboard mappings", ->
					expect(keyboardMappings).toEqual
						"27": "mappedKeyA"
						"50": "mappedKeyB"
						"60": "mappedKeyC"
				it "does not modify other parts of the controller", ->
					expect(controller.mappedKeyA).toEqual 0.3
					expect(controller.mappedKeyC).toEqual 0.4
					expect(controller.unmappedKey).toEqual 0.9
				it "sets the mapped part of the controller to 1", ->
					expect(controller.mappedKeyB).toEqual 1
				it "does not register any further event handlers", ->
					expect(window.addEventListener.calls.count()).toEqual 2
		describe "when a key is released", ->
			describe "and no mapping exists", ->
				beforeEach -> raiseEvent "keyup", 
					keyCode: 51
				it "does not modify the keyboard mappings", ->
					expect(keyboardMappings).toEqual
						"27": "mappedKeyA"
						"50": "mappedKeyB"
						"60": "mappedKeyC"
				it "does not modify the controller", ->
					expect(controller.mappedKeyA).toEqual 0.3
					expect(controller.mappedKeyB).toEqual 0.8
					expect(controller.mappedKeyC).toEqual 0.4
					expect(controller.unmappedKey).toEqual 0.9
				it "does not register any further event handlers", ->
					expect(window.addEventListener.calls.count()).toEqual 2
			describe "and a mapping exists", ->
				beforeEach -> raiseEvent "keyup", 
					keyCode: 50
				it "does not modify the keyboard mappings", ->
					expect(keyboardMappings).toEqual
						"27": "mappedKeyA"
						"50": "mappedKeyB"
						"60": "mappedKeyC"
				it "does not modify other parts of the controller", ->
					expect(controller.mappedKeyA).toEqual 0.3
					expect(controller.mappedKeyC).toEqual 0.4
					expect(controller.unmappedKey).toEqual 0.9
				it "sets the mapped part of the controller to 0", ->
					expect(controller.mappedKeyB).toEqual 0
				it "does not register any further event handlers", ->
					expect(window.addEventListener.calls.count()).toEqual 2
