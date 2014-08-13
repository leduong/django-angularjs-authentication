"use strict"
LIVERELOAD_PORT = 35728
lrSnippet = require("connect-livereload")(port: LIVERELOAD_PORT)

# var conf = require('./conf.'+process.env.NODE_ENV);
mountFolder = (connect, dir) ->
	connect.static require("path").resolve(dir)


# # Globbing
# for performance reasons we're only matching one level down:
# 'test/spec/{,*}*.js'
# use this if you want to recursively match all subfolders:
# 'test/spec/**/*.js'
module.exports = (grunt) ->
	require("load-grunt-tasks") grunt
	require("time-grunt") grunt

	# configurable paths
	yeomanConfig =
		app: "source"
		dist: "public"

	try
		yeomanConfig.app = require("./bower.json").appPath or yeomanConfig.app
	grunt.initConfig
		yeoman: yeomanConfig
		watch:
			coffee:
				files: ["<%= yeoman.app %>/js/**/*.coffee"]
				tasks: ["coffee:dist"]

			compass:
				files: ["<%= yeoman.app %>/styles/**/*.{scss,sass}"]
				tasks: ["compass:server"]

			less:
				files: ["<%= yeoman.app %>/styles-less/**/*.less"]
				tasks: ["less:server"]

			livereload:
				options:
					livereload: LIVERELOAD_PORT

				files: [
					"<%= yeoman.app %>/index.html"
					"<%= yeoman.app %>/views/**/*.html"
					"<%= yeoman.app %>/styles/**/*.scss"
					"<%= yeoman.app %>/styles-less/**/*.less"
					".tmp/css/**/*.css"
					"{.tmp,<%= yeoman.app %>}/js/**/*.js"
					"<%= yeoman.app %>/img/**/*.{png,jpg,jpeg,gif,webp,svg}"
				]

		connect:
			options:
				port: 9000

				# Change this to '0.0.0.0' to access the server from outside.
				hostname: "localhost"

			livereload:
				options:
					middleware: (connect) ->
						[lrSnippet, mountFolder(connect, ".tmp"), mountFolder(connect, yeomanConfig.app)]

			test:
				options:
					middleware: (connect) ->
						[mountFolder(connect, ".tmp"), mountFolder(connect, "test")]

			dist:
				options:
					middleware: (connect) ->
						[mountFolder(connect, yeomanConfig.dist)]

		open:
			server:
				url: "http://localhost:<%= connect.options.port %>"

		clean:
			dist:
				files: [
					dot: true
					src: [".tmp", "<%= yeoman.dist %>/*", "!<%= yeoman.dist %>/.git*"]
				]

			server: ".tmp"

		jshint:
			options:
				jshintrc: ".jshintrc"

			all: ["Gruntfile.js", "<%= yeoman.app %>/js/**/*.js"]

		requirejs:
			compile:
				options:
					baseUrl: ".tmp/js"
					mainConfigFile: ".tmp/js/main.js"

					#dir: 'public/js',
					optimize: "uglify2"
					uglify2:

						#Example of a specialized config. If you are fine
						#with the default options, no need to specify
						#any of these properties.
						output:
							beautify: true

						compress:
							sequences: false
							global_defs:
								DEBUG: false

						warnings: true
						mangle: false

					name: "main"
					out: "<%= yeoman.dist %>/js/main.min.js"
		compass:
			options:
				sassDir: "<%= yeoman.app %>/styles"
				cssDir: ".tmp/css"
				generatedImagesDir: ".tmp/css/ui/images/"
				imagesDir: "<%= yeoman.app %>/styles/ui/images/"
				javascriptsDir: "<%= yeoman.app %>/js"
				fontsDir: "<%= yeoman.app %>/fonts"
				importPath: "<%= yeoman.app %>/bower_components"
				httpImagesPath: "styles/ui/images/"
				httpGeneratedImagesPath: "styles/ui/images/"
				httpFontsPath: "fonts"
				relativeAssets: true
			dist:
				options:
					outputStyle: 'compressed'
					debugInfo: false
					noLineComments: true
			server:
				options:
					debugInfo: true
			forvalidation:
				options:
					debugInfo: false
					noLineComments: false
		# if you want to use the compass config.rb file for configuration:
		# compass:
		#   dist:
		#     options:
		#       config: 'config.rb'

		less:
			server:
				options:
					strictMath: true
					dumpLineNumbers: true
					sourceMap: true
					sourceMapRootpath: ""
					outputSourceFiles: true
				files: [
					expand: true
					cwd: "<%= yeoman.app %>/styles-less"
					src: "main.less"
					dest: ".tmp/css"
					ext: ".css"
				]
			dist:
				options:
					cleancss: true,
					report: 'min'
				files: [
					expand: true
					cwd: "<%= yeoman.app %>/styles-less"
					src: "main.less"
					dest: ".tmp/css"
					ext: ".css"
				]


		coffee:
			server:
				options:
					sourceMap: true
					# join: true,
					sourceRoot: ""
				files: [
					expand: true
					cwd: "<%= yeoman.app %>/js"
					src: "**/*.coffee"
					dest: ".tmp/js"
					ext: ".js"
				]
			dist:
				options:
					sourceMap: false
					sourceRoot: ""
				files: [
					expand: true
					cwd: "<%= yeoman.app %>/js"
					src: "**/*.coffee"
					dest: ".tmp/js"
					ext: ".js"
				]

		useminPrepare:
			html: "<%= yeoman.app %>/index.html"
			options:
				dest: "<%= yeoman.dist %>"
				flow:
					steps:
						js: ["concat"]
						css: ["concat"]
					post: []

		html2js:
			options:{
				module: "App.templates"
				htmlmin: {
					collapseBooleanAttributes: true,
					collapseWhitespace: true,
					removeAttributeQuotes: true,
					removeComments: true,
					removeEmptyAttributes: true,
					removeRedundantAttributes: true,
					removeScriptTypeAttributes: true,
					removeStyleLinkTypeAttributes: true
				}
			}
			main:{
				src: ["source/html/**/*.html"]
				dest: ".tmp/js/templates.js"
			}
		# 'css': ['concat']
		usemin:
			html: ["<%= yeoman.dist %>/**/*.html", "!<%= yeoman.dist %>/bower_components/**"]
			css: ["<%= yeoman.dist %>/css/**/*.css"]
			options:
				dirs: ["<%= yeoman.dist %>"]

		htmlmin:
			dist:
				options: {}

				#removeCommentsFromCDATA: true,
				#                    // https://github.com/yeoman/grunt-usemin/issues/44
				#                    //collapseWhitespace: true,
				#                    collapseBooleanAttributes: true,
				#                    removeAttributeQuotes: true,
				#                    removeRedundantAttributes: true,
				#                    useShortDoctype: true,
				#                    removeEmptyAttributes: true,
				#                    removeOptionalTags: true
				files: [
					expand: true
					cwd: "<%= yeoman.app %>"
					src: ["*.html"]
					dest: "<%= yeoman.dist %>"
				]


		# Put files not handled in other tasks here
		copy:
			dist:
				files: [
					expand: true
					dot: true
					cwd: "<%= yeoman.app %>"
					dest: "<%= yeoman.dist %>"
					src: [
						"favicon.ico"
						"index.php"
						".htaccess"
						"robots.txt"
						# bower components that has image, font dependencies
						#"bower_components/weather-icons/css/*"
						#"bower_components/weather-icons/font/*"

						"fonts/**/*"
						#"i18n/**/*"
						#"images/**/*"
						#"styles/bootstrap/**/*"
						#"styles/fonts/**/*"
						#"styles/img/**/*"
						#"styles/ui/images/**/*"
						#"views/**/*"
						"html/**/*"
					]
				,
					expand: true
					flatten: true
					cwd: "<%= yeoman.app %>"
					dest: "<%= yeoman.dist %>/fonts"
					src: ["bower_components/font-awesome/fonts/*"]
				,
					expand: true
					flatten: true
					cwd: "<%= yeoman.app %>"
					dest: "<%= yeoman.dist %>/css"
					src: ["bower_components/font-awesome/css/*"]
				,
					expand: true
					flatten: true
					cwd: "<%= yeoman.app %>"
					dest: "<%= yeoman.dist %>/img"
					src: ["images/**/*"]
				,
					expand: true
					cwd: ".tmp"
					dest: "<%= yeoman.dist %>"
					src: ["css/**", "assets/**"]
				,
					expand: true
					cwd: ".tmp/img"
					dest: "<%= yeoman.dist %>/img"
					src: ["generated/*"]
				,
					expand: true
					cwd: "<%= yeoman.app %>"
					dest: "app/views/index.php"
					src: ["<%= yeoman.app %>/index.html"]
				]

			styles:
				expand: true
				cwd: "<%= yeoman.app %>/styles"
				dest: ".tmp/css/"
				src: "**/*.css"

		concurrent:
			server: ["coffee:server", "compass:server", "copy:styles"]
			dist: ["coffee:dist", "compass:dist", "copy:styles", "htmlmin"]
			lessServer: ["coffee:server", "less:server", "copy:styles"]
			lessDist: ["coffee:dist", "less:dist", "copy:styles", "htmlmin"]

		concat:
			options:
				separator: grunt.util.linefeed + ';' + grunt.util.linefeed

		ngmin: {
			dist: {
				files: [
					{
						expand: true,
						cwd: '.tmp/js',
						src: '*.js',
						dest: '.tmp/js'
					}
				]
			}
		}

		uglify:
			options:
				report: 'min'
				mangle: false
				compress:
					drop_console: true
			dist:
				files:
					"<%= yeoman.dist %>/js/main.min.js": [
						".tmp/js/app.js"
						".tmp/js/services.js"
						".tmp/js/filters.js"
						".tmp/js/directives.js"
						".tmp/js/controllers.js"
						#".tmp/js/templates.js"
					]


	grunt.registerTask "server", (target) ->
		return grunt.task.run(["build", "open", "connect:dist:keepalive"])  if target is "dist"
		grunt.task.run ["clean:server", "html2js", "concurrent:server", "connect:livereload", "open", "watch"]

	grunt.registerTask "lessServer", (target) ->
		return grunt.task.run(["buildLess", "open", "connect:dist:keepalive"])  if target is "dist"
		grunt.task.run ["clean:server", "concurrent:lessServer", "connect:livereload", "open", "watch"]

	grunt.registerTask "build", [
		"clean:dist"
		"html2js"
		"useminPrepare"
		"concurrent:dist"
		"copy:dist"
		"concat"
		"ngmin"
		"uglify"
		#"requirejs"
		"usemin"
	]
	grunt.registerTask "buildLess", ["clean:dist", "html2js", "useminPrepare", "concurrent:lessDist", "copy:dist", "concat", "ngmin", "uglify", "usemin"]

	grunt.registerTask "default", ["server"]