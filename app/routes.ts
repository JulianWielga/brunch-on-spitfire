class Routes {

	public static $inject = [
		'$stateProvider',
		'$urlRouterProvider',
	]

	constructor(private $stateProvider,
				private $urlRouterProvider) {
		this.$urlRouterProvider.otherwise('/');
		this.$stateProvider
			.state('home', {
				url: '/',
				templateUrl: '/templates/main/index.html',
				controller: 'MainController as MC',
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
