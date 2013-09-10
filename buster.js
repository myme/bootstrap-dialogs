var config = module.exports;

config['Bootstrap Dialog tests'] = {
  environment: 'browser',
  rootPath: '.',
  libs: [
    'bower_components/jquery/jquery.js',
    'bower_components/bootstrap/docs/assets/js/bootstrap-modal.js'
  ],
  sources: [
    'dist/bootstrap-dialogs.js'
  ],
  tests: [
    'dist/bootstrap-dialogs-test.js'
  ]
};
