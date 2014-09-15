'use-strict'

angular.module('app.environments', []).constant 'environmentConfig',
	env: 'dev'
	api: "#{window.location.protocol}//#{window.location.hostname}:8080/"
	appId: ''