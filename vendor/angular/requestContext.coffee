'use strict'

angular.module 'RequestContext', []

.factory 'requestContext', [
	'RenderContext'
	(RenderContext) ->
		action = ""
		sections = []
		params = {}
		previousAction = ""
		previousParams = {}

		getAction = -> action

		getNextSection = (prefix) ->
			return null unless startsWith prefix
			return sections[0] if prefix is ""

			depth = prefix.split(".").length

			return null if depth is sections.length

			sections[depth]

		getParam = (name, defaultValue) ->
			defaultValue = null if angular.isUndefined(defaultValue)
			params[name] or defaultValue

		getParamAsInt = (name, defaultValue) ->
			valueAsInt = @getParam(name, defaultValue or 0) * 1

			if isNaN(valueAsInt)
				defaultValue or 0
			else
				valueAsInt

		getRenderContext = (requestActionLocation, paramNames) ->
			requestActionLocation ?= ""
			paramNames ?= []
			paramNames = [paramNames] unless angular.isArray(paramNames)
			new RenderContext(this, requestActionLocation, paramNames)

		hasActionChanged = ->
			action isnt previousAction

		hasParamChanged = (paramName, paramValue) ->
			return not isParam(paramName, paramValue) unless angular.isUndefined(paramValue)

			unless previousParams.hasOwnProperty(paramName) and params.hasOwnProperty(paramName)
				return true
			else
				return true if previousParams.hasOwnProperty(paramName) and not params.hasOwnProperty(paramName)

			previousParams[paramName] isnt params[paramName]

		haveParamsChanged = (paramNames) ->
			for param in paramNames
				return true if hasParamChanged param
			false

		isParam = (paramName, paramValue) ->
			params.hasOwnProperty(paramName) and (params[paramName] is paramValue)

		setContext = (newAction, newRouteParams) ->
			previousAction = action
			previousParams = params

			action = newAction
			sections = action.split(".")

			params = angular.copy(newRouteParams)

		startsWith = (prefix) ->
			not prefix.length or (action is prefix) or (action.indexOf(prefix + ".") is 0)

		getNextSection: getNextSection
		getParam: getParam
		getParamAsInt: getParamAsInt
		getRenderContext: getRenderContext
		hasActionChanged: hasActionChanged
		hasParamChanged: hasParamChanged
		haveParamsChanged: haveParamsChanged
		isParam: isParam
		setContext: setContext
		startsWith: startsWith
]

.value 'RenderContext', (requestContext, actionPrefix, paramNames) ->
	getNextSection = ->
		requestContext.getNextSection actionPrefix

	isChangeLocal = ->
		requestContext.startsWith actionPrefix

	isChangeRelevant = ->
		return false unless requestContext.startsWith(actionPrefix)
		return true if requestContext.hasActionChanged()
		paramNames.length and requestContext.haveParamsChanged(paramNames)

	getNextSection: getNextSection
	isChangeLocal: isChangeLocal
	isChangeRelevant: isChangeRelevant