/// <reference path="../typings/tsd.d.ts" />

'use strict';

angular.module('app.routes', [
	'ui.router'
])

	.config([
		'$stateProvider',
		'$urlRouterProvider',
		function ($stateProvider, $urlRouterProvider) {
			$urlRouterProvider.otherwise('/');

			$stateProvider
				.state('home', {
					url: '/',
					templateUrl: '/templates/main/index.html',
					controller: 'MainController as MC',
					resolve: {
						dateTime: [
							'testResource',
							function (test) {
								return test.get().$promise;
							}
						]
					}
				});
		}
	]);
