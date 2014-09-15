'use strict'

angular.module 'touk.userServices', [
	'touk.notify'
]

.factory 'UserManager', [
	'$cookieStore'
	'notify'
#	'PermissionManager'
#	'environmentConfig'
	($cookieStore, notify, PermissionManager, config) ->
		new class User
			_cookieName: 'loggedUser'
			isKnown: no

			constructor: ->
				@read()

			getUser: ->
				@_username

			setUser: (user) ->
				return if not user? or user.length < 1 or user is @_username

#				config.loginSound?.play()

				if @isKnown
					notify.info "Przelogowano na #{user}"
				else
					notify.success "Zalogowano jako #{user}"

				@_username = user
				@isKnown = yes
#				PermissionManager.setRole @_username
				@store()

			read: ->
				@_username = $cookieStore.get @_cookieName
				@isKnown = @_username?
#				PermissionManager.setRole @_username

			store: ->
				$cookieStore.put @_cookieName, @_username

			clear: ->
				@_username = null
				@isKnown = no
				$cookieStore.remove @_cookieName
]