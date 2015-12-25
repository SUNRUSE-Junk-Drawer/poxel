describe "setState", ->
	rewire = require "rewire"
	setState = undefined
	beforeEach -> setState = rewire "./setState"
	describe "on calling", ->
		document = undefined
		beforeEach ->
			document = 
				body:
					setAttribute: jasmine.createSpy "setAttribute"
					removeAttribute: jasmine.createSpy "removeAttribute"
			setState.__set__ "document", document
		describe "with details", ->
			beforeEach -> setState "test state", "test details"
			it "does not remove the details attribute", ->
				expect(document.body.removeAttribute).not.toHaveBeenCalledWith "details"
			it "sets the details attribute", ->
				expect(document.body.setAttribute).toHaveBeenCalledWith "details", "test details"
			it "does not remove the state attribute", ->
				expect(document.body.removeAttribute).not.toHaveBeenCalledWith "state"
			it "sets the state attribute", ->
				expect(document.body.setAttribute).toHaveBeenCalledWith "state", "test state"
		describe "without details", ->
			beforeEach -> setState "test state"
			it "removes the details attribute", ->
				expect(document.body.removeAttribute).toHaveBeenCalledWith "details"
			it "does not set a details attribute", ->
				expect(document.body.setAttribute).not.toHaveBeenCalledWith "details", jasmine.any String
			it "does not remove the state attribute", ->
				expect(document.body.removeAttribute).not.toHaveBeenCalledWith "state"
			it "sets the state attribute", ->
				expect(document.body.setAttribute).toHaveBeenCalledWith "state", "test state"
