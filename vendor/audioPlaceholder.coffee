#audio for phantomjs

class SafeAudio
	constructor: (@file) ->
		console.log "Audio not supported by this browser. [#{@file}]"

@Audio ?= SafeAudio
