'use strict'

angular.module 'app', [
	# angular dependencies
	'ngCookies'
	'ngAnimate'
	'ngResource'
	'ngSanitize'
	'ngRoute'

	# angular external dependencies
	'angular-underscore'
	'ui.bootstrap'
	'ui.bootstrap.datetimepicker'
	'angularSpinner'
	'angularMoment'
	'RecursionHelper'
	'RequestContext'

	# environment config
	'app.environments'

	# app modules
	'app.main'

	# jade / html templates and templates
	'app.templates'
]

.config [
	'$routeProvider'
	'$locationProvider'

	($routeProvider, $locationProvider) ->
		$routeProvider

		.when '/a', action: 'a'
		.when '/b', action: 'b'
		.otherwise redirectTo: '/a'

		# Without server side support html5 must be disabled.
		$locationProvider.html5Mode true
]
