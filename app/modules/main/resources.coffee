'use strict'

angular.module 'app.main.resources', [
	'config.api'
]

.factory 'testResource', [
	'$resource'
	'apiConfig'
	($resource, config) ->
		$resource config.testUrl
]

