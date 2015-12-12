describe "cut", ->
	cut = require "./cut"

	generateMapData = (input) -> 
		for y in [-15..15]
			for x in [-15..15]
				for quadrilateral in input 
					switch
						when x < quadrilateral[0][0] then 0
						when x >= quadrilateral[0][1] then 0
						when y < quadrilateral[1][0] then 0
						when y >= quadrilateral[1][1] then 0
						else 1

	generateMap = (mapData) ->
		"\n" + (((((column.reduce (a, b) -> a + b) for column in row).join "") for row in mapData).join "\n")

	for cutY in [-15..15]
		for cutX in [-15..15]
			do (cutX, cutY) ->
				describe "at " + cutX + ", " + cutY, ->
					input = mutated = output = undefined
					beforeEach ->
						input = [
							# 1x1
							[[5, 6], [9, 10]]

							# 4x1
							[[-2, 2], [3, 4]]

							# 4x2
							[[-2, 2], [-1, 1]]

							# 1x4
							[[3, 4], [-3, 1]]

							# 2x4
							[[6, 8], [-3, 1]]

							# 2x2
							[[-7, -5], [9, 11]]

							# 1x2
							[[-3, -2], [9, 11]]

							# 2x1
							[[-7, -5], [5, 6]]

							# 4x5
							[[-10, -6], [-7, -2]]
						]
						mutated = JSON.parse JSON.stringify input
						output = cut mutated, cutX, cutY
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
					it "covers the same blocks, excepting the replaced block", -> 
						expected = generateMapData input
						target = expected[cutY + 15][cutX + 15]
						for i, index in target
							target[index] = 0
						expect(generateMap generateMapData mutated).toEqual generateMap expected
					it "returns the correct value", ->
						expected = generateMapData input
						if (expected[cutY + 15][cutX + 15].indexOf 1) isnt -1
							expect(output).toBeTruthy()
						else
							expect(output).toBeFalsy()
