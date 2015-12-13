A library for emulating a "voxel" terrain such as stb_voxel_render but storing/manipulating only the visible faces.
Faces forming rectangles on the same plane with the same texture merge into quadrilaterals automatically and split when necessary.

This has the following advantages:

- Significantly reduced polygon count in most scenarios; a 1x1km plain is just two triangles.
- Significantly reduced memory usage as only the surface is held in memory.
- Reduced network bandwidth when in multiplayer.

And the following disadvantages:

- Any blocks completely enclosed are lost.
- Non-flat data structure is difficult to process as blocks.

# Data structure

    {
		"xn": {
			"5": {
				"dirt": [[
					[20, 24],
					[30, 40]
				]]
			}
		},
		"zp": {
			"6": {
				"sand": [[
					[-15, 20],
					[60, 75]
				]]
			}
		}
	}
	
This defines:

- A quadrilateral at 5 on the X axis, covering 20 to 24 on the Y axis and 30 to 40 on the Z axis, facing towards negative infinity on the X axis, with the "dirt" material.
- A quadrilateral covering -15 to 20 on the X axis and 60 to 75 on the Y axis, at 6 on the Z axis, facing towards positive infinity on the Z axis, with the "sand" material.
 
Please note that only the lower bound is inclusive, so [0, 1] fills the gap between 0 and 1.

# Functions

The export of this package is an object with the following functions as properties:

## Querying

### quadrilateralCovers

Given:

- An array of arrays of integers specifying the area a quadrilateral covers in 2D space.
- An integer specifying a location on the first axis.
- An integer specifying a location on the second axis.

Returns truthy when the quadrilateral described covers the specified location.

### quadrilateralsCover

Given:

- An array of arrays of arrays of integers specifying the areas quadrilaterals in a layer cover.
- An integer specifying a location on the first axis.
- An integer specifying a location on the second axis.

Returns truthy when any quadrilateral described in the layer covers the specified location.

### materialCovering

Given:

- The object inside a layer containing materials as keys and arrays of arrays specifying quadrilaterals as values.
- An integer specifying a location on the first axis.
- An integer specifying a location on the second axis.

Returns the material covering the specified location, if any, else, null.

## Manipulation

### subtractBlock

Given:

- A terrain object.
- An integer specifying a location on the X axis.
- An integer specifying a location on the Y axis.
- An integer specifying a location on the Z axis.
- A string specifing a material.

Manipulates the terrain object to cut a 1x1x1 block out of it at the specified location.
This works on the following rules:

- Any outwards facing quadrilaterals on the block are erased.
- Anywhere an outwards facing quadrilateral was not erased has an inwards facing quadrilateral added.

### addBlock

Given:

- A terrain object.
- An integer specifying a location on the X axis.
- An integer specifying a location on the Y axis.
- An integer specifying a location on the Z axis.
- A string specifing a material.

Manipulates the terrain object to add a 1x1x1 block to it at the specified location.
This works on the following rules:

- Any inwards facing quadrilaterals on the block are erased.
- Anywhere an inwards facing quadrilateral was not erased has an outwards facing quadrilateral added.

### cut

Given:

- An array of arrays of arrays of integers specifying the areas quadrilaterals in a layer cover.
- An integer specifying a location on the first axis.
- An integer specifying a location on the second axis.

Modifies the quadrilateral arrays to make a 1x1 hole at the specified location.
This may change the surrounding quadrilaterals, splitting but not merging them as required to produce the requested topology.
Returns truthy if any changes were made, and falsy if not.

### optimise

Given:

- The array of arrays specifying quadrilaterals inside a material inside a layer.

Modifies the quadrilateral arrays to merge any eligible quadrilaterals into fewer, larger quadrilaterals.
Returns truthy if any changes were made, and falsy if not.

## Rendering

### generateVertices

Given:

- The array of arrays specifying the quadrilaterals on that plane.

Returns integers specifying the vertices of the quadrilaterals on the X and Y axes, flattened into a single array.  (interleaved; XYXYXYXY)
These run in the order NN, NP, PP, PN; clock-wise, starting from the point closest to negative infinity on both axes.

### generateIndices

Given:

- The number of quadrilaterals to generate indices for.

Returns an array of integers representing indices into the array returned by generateVertices.
This is six per quadrilateral, which form triangles to generate those quadrilaterals.
