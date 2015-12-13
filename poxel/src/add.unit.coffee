describe "add", ->
	add = require "./add"

	describe "when the layer is zero", ->
		describe "when the facing direction is not defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
				add terrain, "facingDirectionB", 0, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"0":
							materialB: [
								[[33, 65], [-10, 128]]
							]
		describe "when the layer is not defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
				add terrain, "facingDirectionB", 0, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"0":
							materialB: [
								[[33, 65], [-10, 128]]
							]
		describe "when the material is not defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"0":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
				add terrain, "facingDirectionB", 0, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"0":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
							materialB: [
								[[33, 65], [-10, 128]]
							]
		describe "when everything is defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"0":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
							materialB: [
								[[60, 80], [-40, -20]]
								[[140, 170], [-150, -130]]
							]
				add terrain, "facingDirectionB", 0, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"0":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
							materialB: [
								[[60, 80], [-40, -20]]
								[[140, 170], [-150, -130]]
								[[33, 65], [-10, 128]]
							]

	describe "when the layer is positive", ->
		describe "when the facing direction is not defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
				add terrain, "facingDirectionB", 75, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialB: [
								[[33, 65], [-10, 128]]
							]
		describe "when the layer is not defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"0":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
				add terrain, "facingDirectionB", 75, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"0":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"75":
							materialB: [
								[[33, 65], [-10, 128]]
							]
		describe "when the material is not defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"0":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"75":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
				add terrain, "facingDirectionB", 75, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"0":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"75":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
							materialB: [
								[[33, 65], [-10, 128]]
							]
		describe "when everything is defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"0":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"75":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
							materialB: [
								[[60, 80], [-40, -20]]
								[[140, 170], [-150, -130]]
							]
				add terrain, "facingDirectionB", 75, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"0":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"-100":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"75":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
							materialB: [
								[[60, 80], [-40, -20]]
								[[140, 170], [-150, -130]]
								[[33, 65], [-10, 128]]
							]

	describe "when the layer is negative", ->
		describe "when the facing direction is not defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
				add terrain, "facingDirectionB", -100, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"-100":
							materialB: [
								[[33, 65], [-10, 128]]
							]
		describe "when the layer is not defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"0":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
				add terrain, "facingDirectionB", -100, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"0":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"-100":
							materialB: [
								[[33, 65], [-10, 128]]
							]
		describe "when the material is not defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"0":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"-100":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
				add terrain, "facingDirectionB", -100, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"0":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"-100":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
							materialB: [
								[[33, 65], [-10, 128]]
							]
		describe "when everything is defined", ->
			terrain = undefined
			beforeEach ->
				terrain = 
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"0":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"-100":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
							materialB: [
								[[60, 80], [-40, -20]]
								[[140, 170], [-150, -130]]
							]
				add terrain, "facingDirectionB", -100, "materialB", 33, 65, -10, 128
			it "defines the facing direction, layer, material and quadrilateral", ->
				expect(terrain).toEqual
					facingDirectionA:
						"50":
							materialA: [
								[[20, 30], [10, 50]]
								[[-40, 10], [80, 90]]
							]
							materialC: [
								[[15, 20], [-10, 5]]
								[[95, 105], [30, 40]]
								[[80, 110], [60, 80]]
							]
						"-45":
							materialB: [
								[[10, 20], [90, 100]]
							]
							materialC: [
								[[45, 60], [-20, 30]]
								[[-80, -70], [50, 60]]
							]
						"0":
							materialA: [
								[[60, 80], [-40, -30]]
								[[110, 140], [120, 140]]
								[[50, 70], [20, 30]]
							]
							materialB: [
								[[70, 75], [15, 25]]
								[[-40, -30], [50, 60]]
							]
					facingDirectionB:
						"75":
							materialA: [
								[[65, 70], [20, 25]]
								[[40, 60], [100, 120]]
							]
							materialC: [
								[[35, 40], [20, 50]]
								[[-40, -30], [110, 120]]
								[[70, 80], [-40, -30]]
							]
						"0":
							materialB: [
								[[220, 240], [60, 70]]
								[[30, 40], [50, 80]]
								[[50, 60], [20, 40]]
							]
							materialC: [
								[[100, 135], [180, 190]]
								[[170, 180], [-60, -30]]
							]
						"-100":
							materialA: [
								[[50, 100], [-90, -70]]
								[[222, 333], [4, 5]]
							]
							materialB: [
								[[60, 80], [-40, -20]]
								[[140, 170], [-150, -130]]
								[[33, 65], [-10, 128]]
							]
