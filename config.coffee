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
		watched: ['conf', 'app', 'vendor']
	files:
		javascripts:
			joinTo:
				'js/app.js': /^app/
				'js/vendor.js': /^(bower_components|vendor)/
				'js/config.js': /^conf[\/\\]dev/
			order:
				before: [
					'bower_components/jquery/dist/jquery.js'
					'bower_components/underscore/underscore.js'
				]

		stylesheets:
			joinTo:
				'css/vendor.css': /^(vendor|bower_components)/
				'css/app.css': /^(app)/
			order:
				before: []
				after: []

		templates:
			joinTo:
				'js/templates.js': /^app.*[\/\\]templates[\/\\].*jade$/

	plugins:
		jadeNgtemplates:
			modules: [
				name: "app.templates"
				pattern: /^app.*[\/\\]templates[\/\\].*jade$/
				url: (path) ->
					path.replace /.*[\/\\](.*)\.jade$/, '/templates/$1.html'
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


	overrides:
		production:
			optimize: false #nie działa ta opcja na js - zawsze true
			sourceMaps: true


			files: # not merged with files
				javascripts:
					joinTo:
						'js/app.js': /^app/
						'js/vendor.js': /^(bower_components|vendor)/
						'js/config.js': /^conf[\/\\]prod/
					order:
						before: [
							'bower_components/jquery/dist/jquery.js'
							'bower_components/underscore/underscore.js'
						]

	server:
		port: 3334
		base: '/app'

# export server configuration to jade processor
process?.server = exports.config.server
require 'git-rev'
.long (hash) -> process?.gitHash = hash
