'use strict'

angular.module 'touk.abortableResource', []

.factory 'AbortableResource', [
	'$resource', '$q'
	($resource, $q) -> class
		constructor: (@url, @params, @actions) ->
			@params ?= {}
			@createResource()

		appendAborter: ->
			@aborter = $q.defer()

			action.timeout = @aborter.promise for name, action of @actions

			@aborter.promise.finally => @createResource()

		createResource: ->
			@appendAborter()
			resource = $resource @url, @params, @actions
			@[name] = resource[name] for name, action of @actions

		abort: (reason) -> @aborter.resolve reason or 'ABORT'

]
