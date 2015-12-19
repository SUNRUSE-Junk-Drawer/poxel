describe "blockSubtracted", ->
	rewire = require "rewire"
	blockSubtracted = undefined
	beforeEach -> blockSubtracted = rewire "./blockSubtracted"
	describe "imports", ->
		it "map", -> expect(blockSubtracted.__get__ "map").toBe require "./../map"
		it "poxel", -> expect(blockSubtracted.__get__ "poxel").toBe require "poxel"
	describe "schema", ->
		jsonschema = require "jsonschema"
		it "accepts valid schemas", ->
			expect((jsonschema.validate (
					location: [6, 0, -18]
					material: "test material"
				), blockSubtracted.schema).errors.length).toBeFalsy()

		rejects = (obj) ->
			expect((jsonschema.validate obj, blockSubtracted.schema).errors.length).toBeTruthy()

		it "rejects null", -> rejects null
		it "rejects when location is missing", -> rejects
			material: "test material"
		it "rejects when location is not an array", -> rejects
			location: 23123
			material: "test material"
		it "rejects when location has too few items", -> rejects
			location: [6, 0]
			material: "test material"
		it "rejects when location has too many items", -> rejects
			location: [6, 0, -18, 60]
			material: "test material"
		it "rejects when location contains non-numbers", -> rejects
			location: [6, true, -18]
			material: "test material"
		it "rejects when location contains floats", -> rejects
			location: [6, 0.1, -18]
			material: "test material"
		it "rejects when material is missing", -> rejects
			location: [6, 0, -18]
		it "rejects when material is not a string", -> rejects
			location: [6, 0, -18]
			material: 2387
		it "rejects when additional properties exist", -> rejects
			location: [6, 0, -18]
			material: "test material"
			irrelevant: true
	describe "handler", ->
		configuration = rootSocket = socket = map = poxel = message = canAdd = undefined
		beforeEach ->
			rootSocket = 
				emit: jasmine.createSpy "emit"
			socket = 
				emit: jasmine.createSpy "emit"
			map = 
				terrain: "test terrain"
				materials: ["test material a", "test material b", "test material c"]
			poxel = 
				subtractBlock: jasmine.createSpy "subtractBlock"
				blockInSurface: (terrain, x, y, z) ->
					expect(terrain).toEqual "test terrain"
					expect(x).toEqual 5
					expect(y).toEqual -10
					expect(z).toEqual 108
					canAdd
			canAdd = true
			message = 
				location: [5, -10, 108]
				material: "test material b"

			blockSubtracted.__set__ "map", map
			blockSubtracted.__set__ "poxel", poxel
		describe "when the material is invalid", ->
			beforeEach ->
				message.material = "test material d"
				blockSubtracted.handler rootSocket, socket, message
			it "does not add the block at the requested location", ->
				expect(poxel.subtractBlock).not.toHaveBeenCalled()
			it "does not notify any clients of the change", ->
				expect(rootSocket.emit).not.toHaveBeenCalled()
			it "notifies the client of the error", ->
				expect(socket.emit.calls.count()).toEqual 1
				expect(socket.emit).toHaveBeenCalledWith "eventRejected", ["the requested material is not supported"]
		describe "when it is not possible to add a block at the requested location", ->
			beforeEach -> 
				canAdd = false
				blockSubtracted.handler rootSocket, socket, message
			it "does not add the block at the requested location", ->
				expect(poxel.subtractBlock).not.toHaveBeenCalled()
			it "does not notify any clients of the change", ->
				expect(rootSocket.emit).not.toHaveBeenCalled()
			it "notifies the client of the error", ->
				expect(socket.emit.calls.count()).toEqual 1
				expect(socket.emit).toHaveBeenCalledWith "eventRejected", ["the requested location is not in a surface"]
		describe "when the request is valid", ->
			beforeEach -> 
				blockSubtracted.handler rootSocket, socket, message
			it "adds the block at the requested location", ->
				expect(poxel.subtractBlock.calls.count()).toEqual 1
				expect(poxel.subtractBlock).toHaveBeenCalledWith "test terrain", 5, -10, 108, "test material b"
			it "notifies all clients of the change", ->
				expect(rootSocket.emit.calls.count()).toEqual 1
				expect(rootSocket.emit).toHaveBeenCalledWith "blockSubtracted",
					location: [5, -10, 108]
					material: "test material b"
			it "does not raise an error", ->
				expect(socket.emit).not.toHaveBeenCalled()
