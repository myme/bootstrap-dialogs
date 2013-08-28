module.exports = (grunt) ->

  sources = 'src/**/*.coffee'
  tests = 'test/**/*.coffee'

  grunt.initConfig
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

    karma:
      test:
        options:
          browsers: ['PhantomJS']
          files: [
            'components/jquery/jquery.js'
            'components/bootstrap/js/bootstrap-modal.js'
            'src/**/*.coffee'
            'test/**/*.coffee'
          ]
          frameworks: ['mocha', 'sinon-chai']
          singleRun: true

    uglify:
      dist:
        files:
          'dist/bootstrap-dialogs.min.js': 'dist/bootstrap-dialogs.js'

    watch:
      test:
        files: [
          'Gruntfile.coffee'
          sources
          tests
        ]
        tasks: ['test']

  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-karma')

  grunt.registerTask('lint', ['coffeelint'])
  grunt.registerTask('build', ['lint', 'coffee', 'uglify'])
  grunt.registerTask('dist', ['build', 'copy'])
  grunt.registerTask('start', ['connect', 'test', 'watch'])
  grunt.registerTask('test', ['lint', 'karma:test'])
  grunt.registerTask('default', ['test'])
