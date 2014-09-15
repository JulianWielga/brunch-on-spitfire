'use strict'

angular.module 'touk.focusable', []

.directive 'focusable', [->
	restrict: 'EA'
	scope: yes
	link: (scope, element, attrs) ->
		focus = no
		over = no

		_apply = (f, o) ->
			focus = f
			over = o
			scope.$apply -> scope.focused = focus or over

		element.on 'focusin', -> _apply yes, over
		element.on 'focusout', -> _apply no, over
		element.on 'mouseenter', -> _apply focus, yes
		element.on 'mouseleave', -> _apply focus, no
]
