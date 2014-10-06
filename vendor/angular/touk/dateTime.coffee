'use strict'

angular.module 'touk.dateTime', [
	'ui.bootstrap'
	'ui.bootstrap.datetimepicker'
	'angularMoment'
]

.filter 'dateTimeFormat', [
	'moment'
	(moment) ->
		(date) -> moment(date).format('L HH:mm:ss') if date?
]



.directive 'momentInputFormatter', [
	'moment'
	(moment) ->
		require: 'ngModel'
		scope:
			format: '@format'
		link: (scope, element, attrs, ngModelController) ->
			scope.format = 'L LT' unless scope.format
			ngModelController.$parsers.push (data) -> if data
				moment(data, scope.format).toDate()
			ngModelController.$formatters.push (data) -> if data
				date = moment(data, scope.format, moment.ISO_8601)
				unless date.isValid() then date = moment(data)
				date.format scope.format
]

.run [
	"$templateCache"
	($templateCache) ->
		$templateCache.put "/templates/datepicker.html", "<div is-open=\"datepickerOpened\" ng-form=\"ng-form\" ng-class=\"{dropup: !hasBottomSpace(), dropright: !hasRightSpace()}\" class=\"dropdown\"><span ng-class=\"{\'input-group\': hasReset()}\"><input ng-model=\"date\" ng-disabled=\"disabled\" moment-input-formatter=\"moment-input-formatter\" class=\"form-control dropdown-toggle\"/><span ng-if=\"hasReset()\" class=\"input-group-btn\"><button type=\"button\" ng-click=\"btnAction()\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-screenshot\"></span></button></span></span><div class=\"dropdown-menu unselectable\" ng-click=\"catchClick($event)\"><datetimepicker ng-model=\"date\" on-set-time=\"onSelect\" datetimepicker-config=\"{{config | json}}\"></datetimepicker></div></div>"
]

.directive 'momentDatePicker', [
	'$document'
	'moment'
	($document, moment) ->
		require: 'ngModel'
		templateUrl: '/templates/datepicker.html'
		restrict: 'AEC'
		scope:
			date: '=ngModel'
			disabled: '=ngDisabled'
			model: '@ngModel'
			startView: '@mdpStartView'
			minView: '@mdpMinView'
			reset: '&mdpResetTo'
			format: '@'

		compile: (tElement, tAttrs) ->
			input = tElement.find 'input'

			for own attr, value of tAttrs
				do (attr = tAttrs.$attr[attr], value) ->
					return unless attr or attr?.startsWith 'mdp'
					input.attr attr, value unless input.attr attr

			pre: (scope, element, attrs, model) ->
				scope.config =
					startView: scope.startView
					minView: scope.minView

			post: (scope, element, attrs, model) ->

				angular.extend scope,
					hasBottomSpace: ->
						$document.height() - element.offset().top > 200

					hasRightSpace: ->
						$document.width() - element.offset().left > 200

					onSelect: (value) ->
						scope.datepickerOpened = no
						model.$setViewValue moment(value)

					hasReset: -> attrs.mdpResetTo? or attrs.mdpReset?

					btnAction: ->
						model.$setViewValue scope.reset?() or new Date()

					catchClick: (event) ->
						event?.preventDefault()
						event?.stopPropagation()

]
