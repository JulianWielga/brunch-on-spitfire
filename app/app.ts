/// <reference path="../typings/tsd.d.ts" />

'use strict';

angular.module('app', [
	'ngResource',
	'ngSanitize',
	'ngMessages',
	'ngAnimate',
	'angular-lodash',
	'templates',
	'config'
])

	.config([
		'$locationProvider',
		function ($locationProvider) {
			$locationProvider.html5Mode(true);
		}
	]);