'use strict'

angular.module 'touk.focusMe', []

.directive 'focusMe', [
	'$timeout'
	($timeout) ->
		priority: 0
		scope:
			focusMe: '='
		link: (scope, elm, attrs) ->
			$timeout (->
				if scope.focusMe or not attrs.focusMe
					element = if attrs.uiSelect2? then elm.siblings('.select2-container').find('input')[0] else elm[0]
					element.focus()
			), 100
]