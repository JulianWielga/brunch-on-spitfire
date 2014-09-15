'use strict'

angular.module 'touk.adjustHeight', []

.directive 'adjustHeightTo', [
	'$timeout'
	($timeout) ->
		restrict: 'A'
		link: (scope, element, attrs) ->
			THROTTLE = 1000

			heightListener = null

			showErrorMessage = (which) ->
				console.warn "Nothing to do, adjust-height-to #{unless which? then 'not set' else 'invalid'}!"

			checkHeightOfOne = (element, border) ->
				console.log 'checkHeightOfOne'
				if border
					parseInt(element.css 'height')
				else
					parseInt(element.css 'height') - parseInt(element.css 'borderBottomWidth') - parseInt(element.css 'borderTopWidth')

			checkHeightOfMultiple = (elements, border) ->
				console.log 'checkHeightOfMultiple'
				result = 0
				for el in elements
					result += checkHeightOfOne angular.element(el), border
				result

			doAdjustment = (newHeight) ->
				console.log 'doAdjustment', newHeight
				element.css height: newHeight

			adjustTo = (elements, subtrahend) ->
				if elements.length is 1 then checkHeight = checkHeightOfOne
				else checkHeight = checkHeightOfMultiple
				watchFn = _.throttle ->
					height = checkHeight elements
					if subtrahend?
						height - checkHeightOfMultiple subtrahend, yes
				, THROTTLE, leading: no
				heightListener = scope.$watch watchFn, doAdjustment


			attrs.$observe 'adjustHeightTo', (which) ->
				heightListener?() #clear watch
				elements = null
				subtrahend = 0

				switch which
					when 'parent' then elements = element.parent()
					when 'parent without siblings'
						elements = element.parent()
						subtrahend = element.siblings()
					when 'first child' then elements = element.children().eq(0)
					when 'children' then elements = element.children()
					else
						elements = angular.element(which)
						return showErrorMessage which unless elements?.length > 0

				adjustTo elements, subtrahend

]
