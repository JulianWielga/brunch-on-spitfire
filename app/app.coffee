'use strict'

angular.module 'app', [
	'ngResource'
	'ngSanitize'
	'ngMessages'
	'ngAnimate'

	'angular-lodash'

	'templates'
	'config'
]

.config [
	'$locationProvider', ($locationProvider) ->
		# Without server side support html5 must be disabled.
		$locationProvider.html5Mode yes
]