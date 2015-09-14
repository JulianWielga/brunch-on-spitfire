'use strict';

angular.module('app.main.resources', [
	'config.api'
])
	.factory('testResource', [
		'$resource',
		'apiConfig',
		function ($resource, config) {
			return $resource(config.testUrl);
		}
	]);
