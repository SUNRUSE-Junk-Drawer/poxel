describe "index", ->
	index = require "./index"
	it "imports cut", -> expect(index.cut).toBe require "./cut"
	it "imports generateVertices", -> expect(index.generateVertices).toBe require "./generateVertices"
	it "imports generateIndices", -> expect(index.generateIndices).toBe require "./generateIndices"
	it "imports quadrilateralCovers", -> expect(index.quadrilateralCovers).toBe require "./quadrilateralCovers"
	it "imports quadrilateralsCover", -> expect(index.quadrilateralsCover).toBe require "./quadrilateralsCover"
