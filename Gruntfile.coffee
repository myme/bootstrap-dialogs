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

    jshint:
      assets: 'buster.js'

    watch:
      test:
        files: [
          'Gruntfile.coffee'
          'buster.js'
          sources
          tests
        ]
        tasks: 'test'

  grunt.loadNpmTasks('grunt-buster')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-jshint')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('lint', ['coffeelint', 'jshint'])
  grunt.registerTask('build', ['lint', 'coffee'])
  grunt.registerTask('test', ['build', 'buster'])
  grunt.registerTask('default', ['test'])
