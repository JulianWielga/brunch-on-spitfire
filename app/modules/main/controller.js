'use strict';

angular.module('app.main.controller', [])
	.controller('MainController', [
		'testResource',
		'dateTime',
		function ($test, $dateTime) {
			return {
				greet: 'spitfire',
				dateTime: $dateTime,
				save: function () {
					this.dateTime.$save();
				},
				save2: function () {
					this.dateTime = $test.save();
				}
			}
		}
	]);
