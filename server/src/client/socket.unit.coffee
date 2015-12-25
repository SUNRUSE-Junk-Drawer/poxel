describe "socket", ->
	rewire = require "rewire"
	socket = undefined
	beforeEach -> socket = rewire "./socket"

	describe "imports", ->
		it "setState", -> expect(socket.__get__ "setState").toBe require "./setState"

	describe "on calling", ->
		listens = setState = io = rootSocket = undefined
		beforeEach ->
			bodyAttributes = 
				state: "loading"

			setState = jasmine.createSpy "setState"
			socket.__set__ "setState", setState
			
			rootSocket = 
				on: jasmine.createSpy "on"

			io = jasmine.createSpy "io"
			io.and.returnValue rootSocket
			socket.__set__ "io", io

			socket()
			listens = rootSocket.on.calls.count()

		raiseEvent = (name) ->
			(args[1] for args in rootSocket.on.calls.allArgs() when args[0] is name)[0]()

		it "creates a new socket", ->
			expect(io.calls.count()).toEqual 1
		it "sets the body state to \"connecting\"", ->
			expect(setState.calls.count()).toEqual 1
			expect(setState).toHaveBeenCalledWith "connecting"
		it "binds to the \"connect\" event of the socket", -> 
			expect(rootSocket.on).toHaveBeenCalledWith "connect", jasmine.any Function
		it "binds to the \"connect_error\" event of the socket", -> 
			expect(rootSocket.on).toHaveBeenCalledWith "connect_error", jasmine.any Function
		it "binds to the \"connect_timeout\" event of the socket", -> 
			expect(rootSocket.on).toHaveBeenCalledWith "connect_timeout", jasmine.any Function
		it "binds to the \"reconnect\" event of the socket", -> 
			expect(rootSocket.on).toHaveBeenCalledWith "reconnect", jasmine.any Function
		it "binds to the \"reconnecting\" event of the socket", -> 
			expect(rootSocket.on).toHaveBeenCalledWith "reconnecting", jasmine.any Function
		it "binds to the \"reconnect_error\" event of the socket", -> 
			expect(rootSocket.on).toHaveBeenCalledWith "reconnect_error", jasmine.any Function
		it "binds to the \"reconnect_failed\" event of the socket", -> 
			expect(rootSocket.on).toHaveBeenCalledWith "reconnect_failed", jasmine.any Function
		describe "when the \"connect\" event is raised", ->
			beforeEach -> raiseEvent "connect"
			it "does not create further sockets", ->
				expect(io.calls.count()).toEqual 1
			it "does not listen for further events", ->
				expect(rootSocket.on.calls.count()).toEqual listens
			it "sets the body state to \"connected\"", ->
				expect(setState.calls.count()).toEqual 2
				expect(setState).toHaveBeenCalledWith "connected"
		describe "when the \"connect_error\" event is raised", ->
			beforeEach -> raiseEvent "connect_error"
			it "does not create further sockets", ->
				expect(io.calls.count()).toEqual 1
			it "does not listen for further events", ->
				expect(rootSocket.on.calls.count()).toEqual listens
			it "sets the body state to \"failedToConnect\"", ->
				expect(setState.calls.count()).toEqual 2
				expect(setState).toHaveBeenCalledWith "failedToConnect"
		describe "when the \"connect_timeout\" event is raised", ->
			beforeEach -> raiseEvent "connect_timeout"
			it "does not create further sockets", ->
				expect(io.calls.count()).toEqual 1
			it "does not listen for further events", ->
				expect(rootSocket.on.calls.count()).toEqual listens
			it "sets the body state to \"connectionTimeout\"", ->
				expect(setState.calls.count()).toEqual 2
				expect(setState).toHaveBeenCalledWith "connectionTimeout"
		describe "when the \"reconnect\" event is raised", ->
			beforeEach -> raiseEvent "reconnect"
			it "does not create further sockets", ->
				expect(io.calls.count()).toEqual 1
			it "does not listen for further events", ->
				expect(rootSocket.on.calls.count()).toEqual listens
			it "sets the body state to \"connected\"", ->
				expect(setState.calls.count()).toEqual 2
				expect(setState).toHaveBeenCalledWith "connected"
		describe "when the \"reconnecting\" event is raised", ->
			beforeEach -> raiseEvent "reconnecting"
			it "does not create further sockets", ->
				expect(io.calls.count()).toEqual 1
			it "does not listen for further events", ->
				expect(rootSocket.on.calls.count()).toEqual listens
			it "sets the body state to \"reconnecting\"", ->
				expect(setState.calls.count()).toEqual 2
				expect(setState).toHaveBeenCalledWith "reconnecting"
		describe "when the \"reconnect_error\" event is raised", ->
			beforeEach -> raiseEvent "reconnect_error"
			it "does not create further sockets", ->
				expect(io.calls.count()).toEqual 1
			it "does not listen for further events", ->
				expect(rootSocket.on.calls.count()).toEqual listens
			it "sets the body state to \"failedToReconnect\"", ->
				expect(setState.calls.count()).toEqual 2
				expect(setState).toHaveBeenCalledWith "failedToReconnect"
		describe "when the \"reconnect_failed\" event is raised", ->
			beforeEach -> raiseEvent "reconnect_failed"
			it "does not create further sockets", ->
				expect(io.calls.count()).toEqual 1
			it "does not listen for further events", ->
				expect(rootSocket.on.calls.count()).toEqual listens
			it "sets the body state to \"failedToReconnectPermanently\"", ->
				expect(setState.calls.count()).toEqual 2
				expect(setState).toHaveBeenCalledWith "failedToReconnectPermanently"
