A socket.io-based multiplayer server for maps based on the "poxel" library.

# Configuration

Settings are stored in the "configuration.js" file.
The following properties are available:

| Name         | Description                                                               | Example       |
| ------------ | ------------------------------------------------------------------------- | ------------- |
| port         | The port socket.io listens on.                                            | 8080          |

# Protocol

## Server-raised events

### eventRejected

An event raised by the client was rejected.
The message is an array of strings describing why the rejection occurred.

### mapChanged

The message is an object containing:

* terrain: The new terrain object.
* materials: An array of the available materials' names, as strings.

This event will be raised shortly after connecting.

### blockAdded

The message is a JSON object containing:

* location: An array of three integers specifying the X, Y and Z of the block added.
* material: A string specifying the material of the block added.

### blockSubtracted

The message is a JSON object containing:

* location: An array of three integers specifying the X, Y and Z of the block subtracted.
* material: A string specifying the material of the block subtracted.

## Client-raised events

### blockAdded

You should wait for the server to echo this event rather than applying its effect yourself.

The message is a JSON object containing:

* location: An array of three integers specifying the X, Y and Z of the block added.
* material: A string specifying the material of the block added.

The following (non-schema validation) errors may be raised:

* the requested material is not supported
* the requested location is not on a surface

### blockSubtracted

You should wait for the server to echo this event rather than applying its effect yourself.

The message is a JSON object containing:

* location: An array of three integers specifying the X, Y and Z of the block subtracted.
* material: A string specifying the material of the block subtracted.

The following (non-schema validation) errors may be raised:

* the requested material is not supported
* the requested location is not in a surface
