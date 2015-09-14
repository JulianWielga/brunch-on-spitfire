'use strict'

angular.module 'app.main.controller', []

.controller 'MainController', [
	'testResource'
	'dateTime'
	class MainController
		constructor: (@$test, @dateTime) ->
			@greet = 'spitfire'

		save: =>
			@dateTime.$save()

		save2: =>
			@dateTime = @$test.save()
]

