describe "socket", ->
	rewire = require "rewire"
	socket = undefined
	beforeEach -> socket = rewire "./socket"
	describe "imports", ->
		it "configuration", -> expect(socket.__get__ "configuration").toBe require "./configuration"
		it "map", -> expect(socket.__get__ "map").toBe require "./map"
		it "jsonschema", -> expect(socket.__get__ "jsonschema").toBe require "jsonschema"

	describe "on calling", ->
		handlerA = handlerB = handlerC = rootSocket = configuration = map = jsonschema = require = undefined
		beforeEach ->
			rootSocket = 
				on: jasmine.createSpy "on"
			configuration = 
				handlers: ["testHandlerA", "testHandlerB", "testHandlerC"]
			socket.__set__ "configuration", configuration
			handlerA = 
				schema: "test schema a"
				handler: -> fail "unexpected call of handler a"
			handlerB = 
				schema: "test schema b"
				handler: jasmine.createSpy "handlerB"
			handlerC = 
				schema: "test schema c"
				handler: -> fail "unexpected call of handler b"
			require = (name) -> switch name
				when "./handlers/testHandlerA" then handlerA
				when "./handlers/testHandlerB" then handlerB
				when "./handlers/testHandlerC" then handlerC
				else fail "unexpected require of \"" + name + "\""
			socket.__set__ "require", require
			jsonschema = 
				validate: (message, schema) -> 
					expect(schema).toEqual "test schema b"
					switch message
						when "test valid message"
							errors: []
						when "test invalid message"
							errors: [	
										stack: "test stack a"
									,
										stack: "test stack b"
								]
						else fail "unexpected message \"" + message + "\""
			socket.__set__ "jsonschema", jsonschema
			map = 
				materials: "test materials"
				terrain: "test terrain"
				irrelevant: true
			socket.__set__ "map", map
			socket rootSocket
		it "sets up a connection listener", ->
			expect(rootSocket.on.calls.count()).toEqual 1
			expect(rootSocket.on).toHaveBeenCalledWith "connection", jasmine.any Function
		it "does not execute any event handlers", ->
			expect(handlerB.handler).not.toHaveBeenCalled()
		describe "on receiving a connection", ->
			childSocket = undefined
			beforeEach -> 
				childSocket = 
					on: jasmine.createSpy "on"
					emit: jasmine.createSpy "emit"
				(rootSocket.on.calls.argsFor 0)[1] childSocket
			it "sends the terrain and materials only to the client", ->
				expect(childSocket.emit.calls.count()).toEqual 1
				expect(childSocket.emit).toHaveBeenCalledWith "mapChanged", 
					terrain: "test terrain"
					materials: "test materials"
			it "binds one event handler for every in the configuration", ->
				expect(childSocket.on.calls.count()).toEqual 3
				expect(childSocket.on).toHaveBeenCalledWith "testHandlerA", jasmine.any Function
				expect(childSocket.on).toHaveBeenCalledWith "testHandlerB", jasmine.any Function
				expect(childSocket.on).toHaveBeenCalledWith "testHandlerC", jasmine.any Function
			it "does not execute any event handlers", ->
				expect(handlerB.handler).not.toHaveBeenCalled()
			it "does not listen again", ->
				expect(rootSocket.on.calls.count()).toEqual 1
			describe "on calling an event handler", ->
				callback = undefined
				beforeEach ->
					callback = (arg[1] for arg in childSocket.on.calls.allArgs() when arg[0] is "testHandlerB")[0]
				describe "with a valid message", ->
					beforeEach -> callback "test valid message"
					it "does not emit an error back to the client", ->
						expect(childSocket.emit.calls.count()).toEqual 1
					it "executes the handler", ->
						expect(handlerB.handler.calls.count()).toEqual 1
					it "does not listen again", ->	
						expect(rootSocket.on.calls.count()).toEqual 1
						expect(childSocket.on.calls.count()).toEqual 3
				describe "with an invalid message", ->
					beforeEach -> callback "test invalid message"
					it "emits an error back to the client", ->
						expect(childSocket.emit.calls.count()).toEqual 2
						expect(childSocket.emit).toHaveBeenCalledWith "eventRejected", [
								"test stack a"
								"test stack b"
							]
					it "does not execute the handler", ->
						expect(handlerB.handler).not.toHaveBeenCalled()
					it "does not listen again", ->
						expect(rootSocket.on.calls.count()).toEqual 1
						expect(childSocket.on.calls.count()).toEqual 3
