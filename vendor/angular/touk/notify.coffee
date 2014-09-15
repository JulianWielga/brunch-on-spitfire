'use strict'

angular.module 'touk.notify', [
	'Postman'
]

.factory 'notify', [
	'postman'
	(postman) ->
		error: (title, body) -> postman.error title, body
		info: (title, body) -> postman.info title, body
		warning: (title, body) -> postman.warn title, body
		success: (title, body) -> postman.success title, body
]