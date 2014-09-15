'use strict'

angular.module 'touk.dateTime', []

.filter 'dateTimeFormat', [
	'moment'
	(moment) ->
		(date) -> moment(date).format('L HH:mm:ss') if date?
]

.directive 'momentInputFormatter', [
	'moment'
	(moment) ->
		require: 'ngModel'
		scope: yes

		link: (scope, element, attrs, ngModelController) ->
			scope.format = 'L LT' unless scope.format
			ngModelController.$parsers.push (data) ->
				moment(data, scope.format).toDate() if data
			ngModelController.$formatters.push (data) ->
				moment(data).format(scope.format) if data
]

.run [
	"$templateCache"
	($templateCache) ->
		$templateCache.put "/templates/datepicker.html", "<div is-open=\"datepickerOpened\" ng-form=\"ng-form\" ng-class=\"{dropup: !hasBottomSpace()}\" class=\"dropdown\"><span ng-class=\"{'input-group': hasReset()}\"><input ng-model=\"date\" moment-input-formatter=\"moment-input-formatter\" class=\"form-control dropdown-toggle\"/><span ng-if=\"hasReset()\" class=\"input-group-btn\"><button type=\"button\" ng-click=\"btnAction()\" class=\"btn btn-default\"><span class=\"glyphicon glyphicon-screenshot\"></span></button></span></span><div class=\"dropdown-menu unselectable\"><datetimepicker ng-model=\"date\" on-set-time=\"onSelect\" datetimepicker-config=\"{{config | json}}\"></datetimepicker></div></div>"
]

.directive 'momentDatePicker', [
	'$document'
	($document) ->
		require: 'ngModel'
		templateUrl: '/templates/datepicker.html'
		restrict: 'AEC'
		scope:
			date: '=ngModel'
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
				scope.hasBottomSpace = ->
					$document.height() - element.offset().top > 200

				scope.onSelect = (value) ->
					scope.datepickerOpened = no
					model.$setViewValue value

				scope.hasReset = -> attrs.mdpResetTo? or attrs.mdpReset?
				scope.btnAction = ->
					model.$setViewValue scope.reset?() or new Date()

]
