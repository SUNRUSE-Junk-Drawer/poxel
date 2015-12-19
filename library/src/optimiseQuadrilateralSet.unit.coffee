describe "optimiseQuadrilateralSet", ->
	optimiseQuadrilateralSet = require "./optimiseQuadrilateralSet"

	generateMapData = (input) -> 
		for y in [-5...20]
			for x in [-5...20]
				for quadrilateral in input 
					switch
						when x < quadrilateral[0][0] then 0
						when x >= quadrilateral[0][1] then 0
						when y < quadrilateral[1][0] then 0
						when y >= quadrilateral[1][1] then 0
						else 1

	generateMap = (input) ->
		"\n" + (((((column.reduce (a, b) -> a + b) for column in row).join "") for row in (generateMapData input)).join "\n")

	check = (description, expectedTiles, input) ->
		describe description, ->
			mutated = output = undefined
			beforeEach ->
				mutated = JSON.parse JSON.stringify input
				output = optimiseQuadrilateralSet mutated
			it "does not create degenerate quadrilaterals", ->
				for quadrilateral in mutated
					expect(quadrilateral[0][0] <= quadrilateral[0][1]).toBeTruthy "A quadrilateral was degenerate on X " + JSON.stringify quadrilateral
					expect(quadrilateral[1][0] <= quadrilateral[1][1]).toBeTruthy "A quadrilateral was degenerate on Y " + JSON.stringify quadrilateral
			it "does not create overlapping quadrilaterals", -> 
				for row, y in generateMapData mutated
					for column, x in row
						total = 0
						total++ for quadrilateral in column when quadrilateral is 1
						expect(total < 2).toBeTruthy "Overlap at " + x + ", " + y
			it "covers the same blocks", -> expect(generateMap mutated).toEqual generateMap input
			if expectedTiles is input.length
				it "returns falsy", -> expect(output).toBeFalsy()
				it "does not change the number of quadrilaterals", -> expect(mutated.length).toEqual(input.length)
			else
				xit "returns truthy", -> expect(output).toBeTruthy()
				xit "reduces the quadrilateral count", -> expect(mutated.length).toEqual expectedTiles

	check "lone quadrilateral", 1, [
		[[3, 7], [10, 14]]
	]

	describe "complex scenario", ->
		checkFor = (name, expectedTiles, options) ->
			describe name, ->
				recurse = (subOptions, after) ->
					tabs = ("\t" for item in after).join ""
					if not subOptions.length
						choices = []
						for reference in after
							choices.push JSON.parse JSON.stringify (options[reference])
						check (after.join ""), expectedTiles, choices
					else
						for item, index in subOptions
							subSubOptions = JSON.parse JSON.stringify subOptions
							subSubOptions.splice index, 1
							subAfter = JSON.parse JSON.stringify after
							subAfter.push item
							recurse subSubOptions, subAfter
				recurse [0...options.length], []
			
		# This is a 2x2 grid with two blocks attached at the corner:
		#      .
		#    ...
		#    ..
		# This should merge into two blocks; the 2x2 and the 1x2.
		# If this algorithm is sub-optimal, it may mis-allocate the quads and create more than the optimal 2:
		#      b
		#    aab
		#    aa

		describe "square and top-right extension", ->
			checkFor "pre-broken", 2, [
				[[3, 7], [2, 5]]
				[[7, 9], [2, 5]]
				[[3, 7], [5, 10]]
				[[7, 9], [5, 10]]
				[[9, 14], [5, 10]]
				[[9, 14], [10, 13]]
			]

			checkFor "already optimised", 2, [
				[[3, 9], [2, 10]]
				[[9, 14], [5, 13]]
			]

			checkFor "split required to optimise", 2, [
				[[3, 9], [2, 5]]
				[[3, 14], [5, 10]]
				[[9, 14], [10, 13]]
			]

		describe "square and bottom-right extension", ->
			checkFor "pre-broken", 2, [
				[[3, 7], [2, 5]]
				[[7, 9], [2, 5]]
				[[3, 7], [5, 10]]
				[[7, 9], [5, 10]]
				[[9, 14], [-2, 2]]
				[[9, 14], [2, 5]]
			]

			checkFor "already optimised", 2, [
				[[3, 9], [2, 10]]
				[[9, 14], [-2, 5]]
			]

			checkFor "split required to optimise", 2, [
				[[3, 9], [5, 10]]
				[[3, 14], [2, 5]]
				[[9, 14], [-2, 2]]
			]

		describe "square and top-left extension", ->
			checkFor "pre-broken", 2, [
				[[3, 7], [2, 5]]
				[[7, 9], [2, 5]]
				[[3, 7], [5, 10]]
				[[7, 9], [5, 10]]
				[[1, 3], [5, 10]]
				[[1, 3], [10, 13]]
			]

			checkFor "already optimised", 2, [
				[[3, 9], [2, 10]]
				[[1, 3], [5, 13]]
			]

			checkFor "split required to optimise", 2, [
				[[3, 9], [2, 5]]
				[[1, 9], [5, 10]]
				[[1, 3], [10, 13]]
			]

		describe "square and bottom-left extension", ->
			checkFor "pre-broken", 2, [
				[[3, 7], [2, 5]]
				[[7, 9], [2, 5]]
				[[3, 7], [5, 10]]
				[[7, 9], [5, 10]]
				[[1, 3], [-2, 2]]
				[[1, 3], [2, 5]]
			]

			checkFor "already optimised", 2, [
				[[3, 9], [2, 10]]
				[[1, 3], [-2, 5]]
			]

			checkFor "split required to optimise", 2, [
				[[3, 9], [5, 10]]
				[[1, 9], [2, 5]]
				[[1, 3], [-2, 2]]
			]

	describe "merge along x", ->
		describe "left then right", ->
			check "successful", 1, [
				[[3, 7], [10, 14]]
				[[7, 10], [10, 14]]
			]

			check "separated on x", 2, [
				[[3, 7], [10, 14]]
				[[8, 10], [10, 14]]
			]

			check "top of left too high", 2, [
				[[3, 7], [10, 15]]
				[[7, 10], [10, 14]]
			]

			check "top of left too low", 2, [
				[[3, 7], [10, 13]]
				[[7, 10], [10, 14]]
			]

			check "bottom of left too high", 2, [
				[[3, 7], [11, 14]]
				[[7, 10], [10, 14]]
			]

			check "bottom of left too low", 2, [
				[[3, 7], [9, 14]]
				[[7, 10], [10, 14]]
			]

		describe "right then left", ->
			check "successful", 1, [
				[[7, 10], [10, 14]]
				[[3, 7], [10, 14]]
			]

			check "separated on x", 2, [
				[[8, 10], [10, 14]]
				[[3, 7], [10, 14]]
			]

			check "top of left too high", 2, [
				[[7, 10], [10, 15]]
				[[3, 7], [10, 14]]
			]

			check "top of left too low", 2, [
				[[7, 10], [10, 13]]
				[[3, 7], [10, 14]]
			]

			check "bottom of left too high", 2, [
				[[7, 10], [11, 14]]
				[[3, 7], [10, 14]]
			]

			check "bottom of left too low", 2, [
				[[7, 10], [9, 14]]
				[[3, 7], [10, 14]]
			]

	describe "merge along y", ->
		describe "bottom then top", ->
			check "successful", 1, [
				[[7, 10], [2, 5]]
				[[7, 10], [5, 9]]
			]

			check "separated on y", 2, [
				[[7, 10], [2, 5]]
				[[7, 10], [6, 9]]
			]

			check "left of bottom too left", 2, [
				[[6, 10], [2, 5]]
				[[7, 10], [5, 9]]
			]

			check "left of bottom too right", 2, [
				[[8, 10], [2, 5]]
				[[7, 10], [5, 9]]
			]

			check "right of bottom too left", 2, [
				[[7, 10], [2, 5]]
				[[6, 10], [5, 9]]
			]

			check "right of bottom too right", 2, [
				[[7, 10], [2, 5]]
				[[8, 10], [5, 9]]
			]

		describe "top then bottom", ->
			check "successful", 1, [
				[[7, 10], [5, 9]]
				[[7, 10], [2, 5]]
			]

			check "separated on y", 2, [
				[[7, 10], [6, 9]]
				[[7, 10], [2, 5]]
			]

			check "left of bottom too left", 2, [
				[[7, 10], [5, 9]]
				[[6, 10], [2, 5]]
			]

			check "left of bottom too right", 2, [
				[[8, 10], [2, 5]]
				[[7, 10], [5, 9]]
			]

			check "right of bottom too left", 2, [
				[[7, 10], [2, 5]]
				[[6, 10], [5, 9]]
			]

			check "right of bottom too right", 2, [
				[[7, 10], [2, 5]]
				[[8, 10], [5, 9]]
			]
