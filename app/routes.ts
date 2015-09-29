module app.routes {
	export class Routes {

		public static $inject = [
			'$stateProvider',
			'$urlRouterProvider',
		]

		constructor(private $stateProvider:ng.ui.IStateProvider,
					private $urlRouterProvider:ng.ui.IUrlRouterProvider) {
			this.$urlRouterProvider.otherwise('/');
			this.$stateProvider
				.state('home', {
					url: '/',
					templateUrl: '/templates/main/index.html',
					controller: 'TestController as TC',
					resolve: {
						dateTime: [
							'testResource',
							function (test) {
								return test.get();//.$promise;
							}
						]
					}
				});
		}
	}

	angular
		.module('app.routes', ['ui.router'])
		.config(Routes);
}

