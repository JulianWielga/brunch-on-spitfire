angular.module('app', [
	'ngResource',
	'ngSanitize',
	'ngMessages',
	'ngAnimate',
	'angular-lodash',
	'ui.router',
	'templates',
	'config'
])

	.config([
		'$locationProvider',
		function ($locationProvider:ng.ILocationProvider) {
			$locationProvider.html5Mode(true);
		}
	]);


