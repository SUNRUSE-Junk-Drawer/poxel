describe "index", ->
	index = require "./index"
	it "imports cut", -> expect(index.cut).toBe require "./cut"
