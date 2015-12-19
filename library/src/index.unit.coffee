describe "index", ->
	index = require "./index"
	it "imports cutQuadrilateralSet", -> expect(index.cutQuadrilateralSet).toBe require "./cutQuadrilateralSet"
	it "imports cutLayer", -> expect(index.cutLayer).toBe require "./cutLayer"
	it "imports cutTerrain", -> expect(index.cutTerrain).toBe require "./cutTerrain"
	it "imports generateVertices", -> expect(index.generateVertices).toBe require "./generateVertices"
	it "imports generateIndices", -> expect(index.generateIndices).toBe require "./generateIndices"
	it "imports quadrilateralCovers", -> expect(index.quadrilateralCovers).toBe require "./quadrilateralCovers"
	it "imports quadrilateralSetCovers", -> expect(index.quadrilateralSetCovers).toBe require "./quadrilateralSetCovers"
	it "imports materialCoveringInLayer", -> expect(index.materialCoveringInLayer).toBe require "./materialCoveringInLayer"
	it "imports add", -> expect(index.add).toBe require "./add"
	it "imports addBlock", -> expect(index.addBlock).toBe require "./addBlock"
	it "imports subtractBlock", -> expect(index.subtractBlock).toBe require "./subtractBlock"
	it "imports blockOnSurface", -> expect(index.blockOnSurface).toBe require "./blockOnSurface"
