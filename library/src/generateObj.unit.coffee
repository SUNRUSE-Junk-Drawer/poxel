describe "generateObj", ->
	generateObj = require "./generateObj"
	addBlock = require "./addBlock"
	subtractBlock = require "./subtractBlock"

	describe "on calling", ->
		input = inputBackup = output = undefined
		beforeEach ->
			input = {}
			addBlock input, 0, 0, 0, "grass"
			addBlock input, 1, 0, 0, "grass"
			addBlock input, 0, 0, 1, "grass"
			addBlock input, 1, 0, 1, "grass"
			addBlock input, 1, 1, 1, "wood"
			addBlock input, 1, 2, 1, "wood"
			addBlock input, 1, 3, 1, "stone"
			addBlock input, 2, 3, 1, "stone"
			addBlock input, 3, 3, 1, "stone"
			addBlock input, 4, 3, 1, "stone"
			addBlock input, 4, 2, 1, "wood"
			addBlock input, 4, 1, 1, "wood"
			addBlock input, 4, 0, 1, "dirt"
			subtractBlock input, 0, 0, 0, "dirt"
			inputBackup = JSON.parse JSON.stringify input
			output = generateObj input
		it "does not modify the input", -> expect(input).toEqual inputBackup
		it "returns the expected Wavefront OBJ file", -> expect(output).toEqual """
s off
vn -1 0 0
vn 0 0 -1
vn 0 1 0
vn 1 0 0
vn 0 0 1
vn 0 -1 0
v 0 0 -1
v 0 0 -2
v 0 1 -2
v 0 1 -1
vt 0 1
vt 0 2
vt 1 2
vt 1 1
usemtl grass
f -1/-2/1 -2/-3/1 -3/-4/1 -4/-1/1
v 1 1 -1
v 1 1 -2
v 1 2 -2
v 1 2 -1
vt 1 1
vt 1 2
vt 2 2
vt 2 1
usemtl wood
f -1/-2/1 -2/-3/1 -3/-4/1 -4/-1/1
v 1 2 -1
v 1 2 -2
v 1 3 -2
v 1 3 -1
vt 2 1
vt 2 2
vt 3 2
vt 3 1
usemtl wood
f -1/-2/1 -2/-3/1 -3/-4/1 -4/-1/1
v 1 3 -1
v 1 3 -2
v 1 4 -2
v 1 4 -1
vt 3 1
vt 3 2
vt 4 2
vt 4 1
usemtl stone
f -1/-2/1 -2/-3/1 -3/-4/1 -4/-1/1
v 1 0 0
v 1 0 -1
v 1 1 -1
v 1 1 0
vt 0 0
vt 0 1
vt 1 1
vt 1 0
usemtl dirt
f -1/-2/1 -2/-3/1 -3/-4/1 -4/-1/1
v 4 2 -1
v 4 2 -2
v 4 3 -2
v 4 3 -1
vt 2 1
vt 2 2
vt 3 2
vt 3 1
usemtl wood
f -1/-2/1 -2/-3/1 -3/-4/1 -4/-1/1
v 4 1 -1
v 4 1 -2
v 4 2 -2
v 4 2 -1
vt 1 1
vt 1 2
vt 2 2
vt 2 1
usemtl wood
f -1/-2/1 -2/-3/1 -3/-4/1 -4/-1/1
v 4 0 -1
v 4 0 -2
v 4 1 -2
v 4 1 -1
vt 0 1
vt 0 2
vt 1 2
vt 1 1
usemtl dirt
f -1/-2/1 -2/-3/1 -3/-4/1 -4/-1/1
v 2 0 0
v 2 0 -1
v 2 1 -1
v 2 1 0
vt 0 0
vt 0 1
vt 1 1
vt 1 0
usemtl grass
f -4/-4/4 -3/-1/4 -2/-2/4 -1/-3/4
v 2 0 -1
v 2 0 -2
v 2 1 -2
v 2 1 -1
vt 0 1
vt 0 2
vt 1 2
vt 1 1
usemtl grass
f -4/-4/4 -3/-1/4 -2/-2/4 -1/-3/4
v 2 1 -1
v 2 1 -2
v 2 2 -2
v 2 2 -1
vt 1 1
vt 1 2
vt 2 2
vt 2 1
usemtl wood
f -4/-4/4 -3/-1/4 -2/-2/4 -1/-3/4
v 2 2 -1
v 2 2 -2
v 2 3 -2
v 2 3 -1
vt 2 1
vt 2 2
vt 3 2
vt 3 1
usemtl wood
f -4/-4/4 -3/-1/4 -2/-2/4 -1/-3/4
v 5 3 -1
v 5 3 -2
v 5 4 -2
v 5 4 -1
vt 3 1
vt 3 2
vt 4 2
vt 4 1
usemtl stone
f -4/-4/4 -3/-1/4 -2/-2/4 -1/-3/4
v 5 2 -1
v 5 2 -2
v 5 3 -2
v 5 3 -1
vt 2 1
vt 2 2
vt 3 2
vt 3 1
usemtl wood
f -4/-4/4 -3/-1/4 -2/-2/4 -1/-3/4
v 5 1 -1
v 5 1 -2
v 5 2 -2
v 5 2 -1
vt 1 1
vt 1 2
vt 2 2
vt 2 1
usemtl wood
f -4/-4/4 -3/-1/4 -2/-2/4 -1/-3/4
v 5 0 -1
v 5 0 -2
v 5 1 -2
v 5 1 -1
vt 0 1
vt 0 2
vt 1 2
vt 1 1
usemtl dirt
f -4/-4/4 -3/-1/4 -2/-2/4 -1/-3/4
v 1 0 0
v 1 0 -1
v 2 0 -1
v 2 0 0
vt 1 0
vt 1 1
vt 2 1
vt 2 0
usemtl grass
f -4/-3/6 -3/-4/6 -2/-1/6 -1/-2/6
v 0 0 -1
v 0 0 -2
v 1 0 -2
v 1 0 -1
vt 0 1
vt 0 2
vt 1 2
vt 1 1
usemtl grass
f -4/-3/6 -3/-4/6 -2/-1/6 -1/-2/6
v 1 0 -1
v 1 0 -2
v 2 0 -2
v 2 0 -1
vt 1 1
vt 1 2
vt 2 2
vt 2 1
usemtl grass
f -4/-3/6 -3/-4/6 -2/-1/6 -1/-2/6
v 4 0 -1
v 4 0 -2
v 5 0 -2
v 5 0 -1
vt 4 1
vt 4 2
vt 5 2
vt 5 1
usemtl dirt
f -4/-3/6 -3/-4/6 -2/-1/6 -1/-2/6
v 2 3 -1
v 2 3 -2
v 3 3 -2
v 3 3 -1
vt 2 1
vt 2 2
vt 3 2
vt 3 1
usemtl stone
f -4/-3/6 -3/-4/6 -2/-1/6 -1/-2/6
v 3 3 -1
v 3 3 -2
v 4 3 -2
v 4 3 -1
vt 3 1
vt 3 2
vt 4 2
vt 4 1
usemtl stone
f -4/-3/6 -3/-4/6 -2/-1/6 -1/-2/6
v 1 1 0
v 1 1 -1
v 2 1 -1
v 2 1 0
vt 1 0
vt 1 1
vt 2 1
vt 2 0
usemtl grass
f -1/-1/3 -2/-2/3 -3/-3/3 -4/-4/3
v 0 1 -1
v 0 1 -2
v 1 1 -2
v 1 1 -1
vt 0 1
vt 0 2
vt 1 2
vt 1 1
usemtl grass
f -1/-1/3 -2/-2/3 -3/-3/3 -4/-4/3
v 1 4 -1
v 1 4 -2
v 2 4 -2
v 2 4 -1
vt 1 1
vt 1 2
vt 2 2
vt 2 1
usemtl stone
f -1/-1/3 -2/-2/3 -3/-3/3 -4/-4/3
v 2 4 -1
v 2 4 -2
v 3 4 -2
v 3 4 -1
vt 2 1
vt 2 2
vt 3 2
vt 3 1
usemtl stone
f -1/-1/3 -2/-2/3 -3/-3/3 -4/-4/3
v 3 4 -1
v 3 4 -2
v 4 4 -2
v 4 4 -1
vt 3 1
vt 3 2
vt 4 2
vt 4 1
usemtl stone
f -1/-1/3 -2/-2/3 -3/-3/3 -4/-4/3
v 4 4 -1
v 4 4 -2
v 5 4 -2
v 5 4 -1
vt 4 1
vt 4 2
vt 5 2
vt 5 1
usemtl stone
f -1/-1/3 -2/-2/3 -3/-3/3 -4/-4/3
v 1 0 0
v 1 1 0
v 2 1 0
v 2 0 0
vt 1 0
vt 1 1
vt 2 1
vt 2 0
usemtl grass
f -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2
v 1 1 -1
v 1 2 -1
v 2 2 -1
v 2 1 -1
vt 1 1
vt 1 2
vt 2 2
vt 2 1
usemtl wood
f -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2
v 1 2 -1
v 1 3 -1
v 2 3 -1
v 2 2 -1
vt 1 2
vt 1 3
vt 2 3
vt 2 2
usemtl wood
f -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2
v 4 2 -1
v 4 3 -1
v 5 3 -1
v 5 2 -1
vt 4 2
vt 4 3
vt 5 3
vt 5 2
usemtl wood
f -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2
v 4 1 -1
v 4 2 -1
v 5 2 -1
v 5 1 -1
vt 4 1
vt 4 2
vt 5 2
vt 5 1
usemtl wood
f -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2
v 1 3 -1
v 1 4 -1
v 2 4 -1
v 2 3 -1
vt 1 3
vt 1 4
vt 2 4
vt 2 3
usemtl stone
f -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2
v 2 3 -1
v 2 4 -1
v 3 4 -1
v 3 3 -1
vt 2 3
vt 2 4
vt 3 4
vt 3 3
usemtl stone
f -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2
v 3 3 -1
v 3 4 -1
v 4 4 -1
v 4 3 -1
vt 3 3
vt 3 4
vt 4 4
vt 4 3
usemtl stone
f -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2
v 4 3 -1
v 4 4 -1
v 5 4 -1
v 5 3 -1
vt 4 3
vt 4 4
vt 5 4
vt 5 3
usemtl stone
f -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2
v 4 0 -1
v 4 1 -1
v 5 1 -1
v 5 0 -1
vt 4 0
vt 4 1
vt 5 1
vt 5 0
usemtl dirt
f -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2
v 0 0 -1
v 0 1 -1
v 1 1 -1
v 1 0 -1
vt 0 0
vt 0 1
vt 1 1
vt 1 0
usemtl dirt
f -1/-1/2 -2/-2/2 -3/-3/2 -4/-4/2
v 0 0 -2
v 0 1 -2
v 1 1 -2
v 1 0 -2
vt 0 0
vt 0 1
vt 1 1
vt 1 0
usemtl grass
f -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5
v 1 0 -2
v 1 1 -2
v 2 1 -2
v 2 0 -2
vt 1 0
vt 1 1
vt 2 1
vt 2 0
usemtl grass
f -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5
v 1 1 -2
v 1 2 -2
v 2 2 -2
v 2 1 -2
vt 1 1
vt 1 2
vt 2 2
vt 2 1
usemtl wood
f -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5
v 1 2 -2
v 1 3 -2
v 2 3 -2
v 2 2 -2
vt 1 2
vt 1 3
vt 2 3
vt 2 2
usemtl wood
f -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5
v 4 2 -2
v 4 3 -2
v 5 3 -2
v 5 2 -2
vt 4 2
vt 4 3
vt 5 3
vt 5 2
usemtl wood
f -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5
v 4 1 -2
v 4 2 -2
v 5 2 -2
v 5 1 -2
vt 4 1
vt 4 2
vt 5 2
vt 5 1
usemtl wood
f -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5
v 1 3 -2
v 1 4 -2
v 2 4 -2
v 2 3 -2
vt 1 3
vt 1 4
vt 2 4
vt 2 3
usemtl stone
f -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5
v 2 3 -2
v 2 4 -2
v 3 4 -2
v 3 3 -2
vt 2 3
vt 2 4
vt 3 4
vt 3 3
usemtl stone
f -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5
v 3 3 -2
v 3 4 -2
v 4 4 -2
v 4 3 -2
vt 3 3
vt 3 4
vt 4 4
vt 4 3
usemtl stone
f -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5
v 4 3 -2
v 4 4 -2
v 5 4 -2
v 5 3 -2
vt 4 3
vt 4 4
vt 5 4
vt 5 3
usemtl stone
f -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5
v 4 0 -2
v 4 1 -2
v 5 1 -2
v 5 0 -2
vt 4 0
vt 4 1
vt 5 1
vt 5 0
usemtl dirt
f -4/-1/5 -3/-2/5 -2/-3/5 -1/-4/5
	"""
