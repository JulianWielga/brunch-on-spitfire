exports.config =
# See docs at http://brunch.readthedocs.org/en/latest/config.html.
	conventions:
		assets: /^app[\/\\]assets/
		ignored: /^(bower_components[\/\\]bootstrap-less(-themes)?|app[\/\\]styles[\/\\]overrides|(.*?[\/\\])?[_]\w*)/
	modules:
		definition: false
		wrapper: false
	paths:
		public: '_public'
		watched: ['app', 'vendor']
	files:
		javascripts:
			joinTo:
				'js/app.js': /^app/
				'js/vendor.js': /^(bower_components|vendor)/
			order:
				before: [
					'bower_components/jquery/dist/jquery.js'
				]

		stylesheets:
			joinTo:
				'css/vendor.css': /^(vendor|bower_components)/
				'css/app.css': /^(app)/
			order:
				before: [
					'app/styles/bootstrap/bootstrap.less'
				]
				after: []

		templates:
			joinTo:
				'js/templates.js': /^app.*[\/\\]templates[\/\\].*jade$/

	plugins:
		jadeNgtemplates:
			modules: [
				name: "templates"
				pattern: /^app[\/\\]templates[\/\\].*jade$/
				url: (path) ->
					name = path.replace(/^app[\/\\].*templates[\/\\](.*).jade$/, '$1').replace(/[\/\\]/g, '.')
					return "/templates/#{name}.html"
			,
				name: "templates.modules"
				pattern: /^app[\/\\].*[\/\\]templates[\/\\].*jade$/
				url: (path) ->
					dir = path.replace(/^app[\/\\]modules[\/\\](.*)templates[\/\\].*/, '$1')
					name = path.replace(/^app[\/\\]modules[\/\\].*templates[\/\\](.*).jade$/, '$1').replace(/[\/\\]/g, '.')
					return "/templates/#{dir}#{name}.html"
			]
			jade:
				pretty: yes
				doctype: "xml"
				basedir: 'app'
			htmlmin: no

		jadePages:
			pattern: /^app[\/\\]index.jade$/
			jade:
				pretty: yes
				doctype: "xml"
				basedir: 'app'
			htmlmin: no

		assetsmanager:
			copyTo:
				fonts: ['bower_components/bootstrap/dist/fonts/*']

	overrides:
		production:
			optimize: false
			sourceMaps: true

	server:
		port: 3335
		base: ''

# export server configuration to jade processor
process?.server = exports.config.server

process?.git = git = {}
gitRev = require 'git-rev'
gitRev.long (hash) -> git.hash = hash
gitRev.branch (name) -> git.branch = name
gitRev.tag (name) -> git.tag = name
