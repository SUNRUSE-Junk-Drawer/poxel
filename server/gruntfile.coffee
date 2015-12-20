module.exports = (grunt) ->

	grunt.loadNpmTasks module for module in [
			"grunt-contrib-clean"
			"grunt-contrib-copy"
			"grunt-contrib-coffee"
			"grunt-jasmine-nodejs"
			"grunt-contrib-watch"
			"grunt-contrib-jade"
			"grunt-contrib-sass"
			"grunt-contrib-uglify"
			"grunt-webpack"
		]

	grunt.initConfig
		watch:
			build:
				options:
					atBegin: true
				files: ["src/**", "gruntfile.coffee"]
				tasks: ["build"]
		clean:
			dist: "dist"
			build: "build"
		copy:
			dist: 
				files: [
						cwd: "build"
						src: ["**/*.js", "!**/*.unit.js", "!client/**/*.js", "client/index.min.js", "**/*.html", "**/*.css"]
						dest: "dist"
						expand: true
				]
		jade:
			build:
				files: [
						cwd: "src"
						src: ["**/*.jade"]
						dest: "build"
						expand: true
						ext: ".html"
				]
		sass:
			build:
				options:
					style: "compressed"
					sourcemap: "none"
				files:
					"build/client/index.min.css": "src/client/index.sass"
		webpack:
			build:
				entry: "./build/client/index.js"
				output:
					path: "build/client/"
					filename: "index.packed.js"
		uglify:
			build:
				files:
					"build/client/index.min.js": "build/client/index.packed.js"
		coffee:
			build:
				options:
					bare: true
				files: [
						cwd: "src"
						ext: ".js"
						src: ["**/*.coffee", "!**/*.unit.coffee"]
						dest: "build"
						expand: true
					,
						cwd: "src"
						ext: ".unit.js"
						src: "**/*.unit.coffee"
						dest: "build"
						expand: true
				]
		jasmine_nodejs:
			unit:
				options:
					specNameSuffix: ".unit.js"
					reporters:
						console:
							verbosity: 2
				specs: "build/**/*.unit.js"				

	grunt.registerTask "test", ["preBuild", "jasmine_nodejs", "clean:build"]
	grunt.registerTask "preBuild", ["clean:build", "coffee"]
	grunt.registerTask "build", ["preBuild", "jasmine_nodejs", "jade", "sass", "webpack", "uglify", "clean:dist", "copy:dist", "clean:build"]
