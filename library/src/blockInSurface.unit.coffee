describe "blockInSurface", ->
	blockInSurface = require "./blockInSurface"
	addBlock = require "./addBlock"
	subtractBlock = require "./subtractBlock"
	map = mapBackup = undefined
	beforeEach ->
		map = {}
		for z in [6...15]
			for y in [-5...8]
				for x in [20...30]
					addBlock map, x, y, z, "test material"

		for z in [10...13]
			for y in [-1...2]
				for x in [24...27]
					subtractBlock map, x, y, z, "test material"

		mapBackup = JSON.parse JSON.stringify map

	check = (description, x, y, z, expectedResult) ->
		describe description, ->
			result = undefined
			beforeEach ->
				result = blockInSurface map, x, y, z
			it "does not modify the map", -> expect(map).toEqual mapBackup
			if expectedResult
				it "returns truthy", -> expect(result).toBeTruthy()
			else	
				it "returns falsy", -> expect(result).toBeFalsy()

	describe "inside", ->
		check "away from any solid block", 25, 0, 11, false
		check "on a face", 24, 0, 11, false
		check "inside a face", 23, 0, 11, true
		check "inside an edge", 24, 0, 10, false
		check "inside a corner", 24, -1, 10, false
		check "inside a face part of a corner", 23, -1, 10, true

	describe "outside", ->
		check "on the left side of a block", 19, 2, 10, false
		check "off the left side of a block", 18, 2, 10, false
		check "inside the left side of a block", 20, 2, 10, true
		check "two blocks inside the left side of a block", 21, 2, 10, false

		check "on the right side of a block", 30, 2, 10, false
		check "off the right side of a block", 31, 2, 10, false
		check "inside the right side of a block", 29, 2, 10, true
		check "two blocks inside the right side of a block", 28, 2, 10, false

		check "on the top side of a block", 26, 8, 10, false
		check "off the top side of a block", 26, 9, 10, false
		check "inside the top side of a block", 26, 7, 10, true
		check "two blocks inside the top side of a block", 26, 6, 10, false

		check "on the bottom side of a block", 26, -6, 10, false
		check "off the bottom side of a block", 26, -7, 10, false
		check "inside the bottom side of a block", 26, -5, 10, true
		check "two blocks inside the bottom side of a block", 26, -4, 10, false

		check "on the front side of a block", 26, 2, 15, false
		check "off the front side of a block", 26, 2, 16, false
		check "inside the front side of a block", 26, 2, 14, true
		check "two blocks inside the front side of a block", 26, 2, 13, false

		check "on the back side of a block", 26, 2, 5, false
		check "off the back side of a block", 26, 2, 4, false
		check "inside the back side of a block", 26, 2, 6, true
		check "two blocks inside the back side of a block", 26, 2, 7, false

		check "inside the bottom left back corner", 20, -5, 6, true
		check "over the bottom left back corner", 19, -6, 5, false
		check "left of the bottom left back corner", 19, -5, 6, false
		check "below the bottom left back corner", 20, -6, 6, false
		check "behind the bottom left back corner", 20, -5, 5, false

		check "inside the bottom right back corner", 29, -5, 6, true
		check "over the bottom right back corner", 29, -6, 5, false
		check "right of the bottom right back corner", 30, -5, 6, false
		check "below the bottom right back corner", 29, -6, 6, false
		check "behind the bottom right back corner", 29, -5, 5, false

		check "inside the bottom left front corner", 20, -5, 14, true
		check "over the bottom left front corner", 19, -6, 15, false
		check "left of the bottom left front corner", 19, -5, 14, false
		check "below the bottom left front corner", 20, -6, 14, false
		check "in front of the bottom left front corner", 20, -5, 15, false

		check "inside the bottom right front corner", 29, -5, 14, true
		check "over the bottom right front corner", 29, -6, 15, false
		check "right of the bottom right front corner", 30, -5, 14, false
		check "below the bottom right front corner", 29, -6, 14, false
		check "in front of the bottom right front corner", 29, -5, 15, false

		check "inside the bottom left back corner", 20, 7, 6, true
		check "over the bottom left back corner", 19, 8, 5, false
		check "left of the bottom left back corner", 19, 7, 6, false
		check "above the bottom left back corner", 20, 8, 6, false
		check "behind the bottom left back corner", 20, 7, 5, false

		check "inside the bottom right back corner", 29, 7, 6, true
		check "over the bottom right back corner", 29, 8, 5, false
		check "right of the bottom right back corner", 30, 7, 6, false
		check "above the bottom right back corner", 29, 8, 6, false
		check "behind the bottom right back corner", 29, 7, 5, false

		check "inside the top left front corner", 20, 7, 14, true
		check "over the top left front corner", 19, 8, 15, false
		check "left of the top left front corner", 19, 7, 14, false
		check "above the top left front corner", 20, 8, 14, false
		check "in front of the top left front corner", 20, 7, 15, false

		check "inside the top right front corner", 29, 7, 14, true
		check "over the top right front corner", 29, 8, 15, false
		check "right of the top right front corner", 30, 7, 14, false
		check "above the top right front corner", 29, 8, 14, false
		check "in front of the top right front corner", 29, 7, 15, false

		check "inside the back left edge", 20, 1, 6, true
		check "over the back left edge", 19, 1, 5, false
		check "left of the back left edge", 19, 1, 6, false
		check "behind the back left edge", 20, 1, 5, false 

		check "inside the back right edge", 29, 1, 6, true
		check "over the back right edge", 30, 1, 5, false
		check "right of the back right edge", 30, 1, 6, false
		check "behind the back right edge", 29, 1, 5, false 

		check "inside the front left edge", 20, 1, 14, true
		check "over the front left edge", 19, 1, 15, false
		check "left of the front left edge", 19, 1, 14, false
		check "in front of the front left edge", 20, 1, 15, false 

		check "inside the front right edge", 29, 1, 14, true
		check "over the front right edge", 30, 1, 15, false
		check "right of the front right edge", 30, 1, 14, false
		check "in front of the front right edge", 29, 1, 15, false 

		check "inside the back bottom edge", 25, -5, 6, true
		check "over the back bottom edge", 25, -6, 5, false
		check "below the back bottom edge", 25, -6, 6, false
		check "behind the back bottom edge", 25, -5, 5, false 

		check "inside the front bottom edge", 25, -5, 14, true
		check "over the front bottom edge", 25, -6, 15, false
		check "below the front bottom edge", 25, -6, 14, false
		check "behind the front bottom edge", 25, -5, 15, false 

		check "inside the back top edge", 25, 7, 6, true
		check "over the back top edge", 25, 8, 5, false
		check "above the back top edge", 25, 8, 6, false
		check "behind the back top edge", 25, 7, 5, false 

		check "inside the front top edge", 25, 7, 14, true
		check "over the front top edge", 25, 8, 15, false
		check "above the front top edge", 25, 8, 14, false
		check "behind the front top edge", 25, 7, 15, false 

		check "inside the left bottom edge", 20, -5, 10, true
		check "over the left bottom edge", 19, -6, 10, false
		check "below the left bottom edge", 20, -6, 10, false
		check "left of the left bottom edge", 19, -5, 10, false 

		check "inside the right bottom edge", 29, -5, 10, true
		check "over the right bottom edge", 30, -6, 10, false
		check "below the right bottom edge", 29, -6, 10, false
		check "right of the right bottom edge", 30, -5, 10, false 

		check "inside the left top edge", 20, 7, 10, true
		check "over the left top edge", 19, 8, 10, false
		check "above the left top edge", 20, 8, 10, false
		check "left of the left top edge", 19, 7, 10, false 

		check "inside the right top edge", 29, 7, 10, true
		check "over the right top edge", 30, 8, 10, false
		check "above the right top edge", 29, 8, 10, false
		check "right of the right top edge", 30, 7, 10, false
