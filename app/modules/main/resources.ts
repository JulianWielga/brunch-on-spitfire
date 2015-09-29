module app.main.resources {
	export class TestResource {
		public static $inject = [
			'$resource',
			'apiConfig'
		]

		constructor(private $resource,
					private config) {
			return this.$resource(config.testUrl);
		}
	}

	angular
		.module('app.main.resources', ['config.api'])
		.service('testResource', TestResource);
}

