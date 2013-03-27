module.exports = (grunt) ->

  sources = 'src/**/*.coffee'
  tests = 'test/**/*.coffee'

  grunt.initConfig
    buster: {} # Defaults

    coffee:
      dist:
        files:
          'dist/bootstrap-dialogs.js': sources
      tests:
        files:
          'dist/bootstrap-dialogs-test.js': tests

    coffeelint:
      assets: 'Gruntfile.coffee'
      dist: sources
      tests: tests

    connect:
      examples: {}

    copy:
      dist:
        files:
          'bootstrap-dialogs.js': 'dist/bootstrap-dialogs.js'
          'bootstrap-dialogs.min.js': 'dist/bootstrap-dialogs.min.js'

    jshint:
      assets: 'buster.js'

    uglify:
      dist:
        files:
          'dist/bootstrap-dialogs.min.js': 'dist/bootstrap-dialogs.js'

    watch:
      test:
        files: [
          'Gruntfile.coffee'
          'buster.js'
          sources
          tests
        ]
        tasks: ['test']

  grunt.loadNpmTasks('grunt-buster')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('lint', ['coffeelint', 'jshint'])
  grunt.registerTask('build', ['lint', 'coffee', 'uglify'])
  grunt.registerTask('dist', ['build', 'copy'])
  grunt.registerTask('start', ['connect', 'test', 'watch'])
  grunt.registerTask('test', ['build', 'buster'])
  grunt.registerTask('default', ['test'])
