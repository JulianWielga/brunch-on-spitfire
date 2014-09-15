'use strict'

angular.module 'main.services.path', []

.factory 'path', [
	'$location'
	($location) ->
		newPath = (path, changeHistory) ->
			$location.replace() unless changeHistory
			$location.path path

		append: (suffix, changeHistory) ->
			newPath "#{$location.path()}/#{suffix}", changeHistory

		up: (changeHistory) ->
			@replace /[^/]+[/]*$/, '', changeHistory

		last: (replaceWith, changeHistory) ->
			@replace /[^/]+[/]*$/, replaceWith, changeHistory

		replace: (pattern, replaceWith, changeHistory) ->
			newPath $location.path().replace(pattern, replaceWith), changeHistory

]