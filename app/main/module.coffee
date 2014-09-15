'use strict'

### Controllers ###

angular.module 'app.main', [
	'app.environments'

	'main.controllers.main'
]

.config [
	'$httpProvider'
	'environmentConfig'
	($httpProvider, config) ->
		$httpProvider.defaults.useXDomain = yes
		$httpProvider.defaults.withCredentials = yes
		$httpProvider.defaults.headers.common['x-app-id'] = config.appId
]