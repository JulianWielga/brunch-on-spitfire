'use strict'
angular.module 'app.routes', [
	'ui.router'
]

.config [
	'$stateProvider', '$urlRouterProvider'
	($stateProvider, $urlRouterProvider) ->

		$urlRouterProvider
		.otherwise '/'



		$stateProvider
		.state 'home',
			url: '/'
			templateUrl: '/templates/main/index.html'
			controller: 'MainController as MC'
			resolve:
				dateTime: [
					'testResource'
					(test) ->
						test.get().$promise
				]

]