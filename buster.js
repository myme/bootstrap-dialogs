var config = module.exports;

config['Bootstrap Dialog tests'] = {
  environment: 'browser',
  rootPath: '.',
  libs: [
    'components/jquery/jquery.js',
    'components/bootstrap/js/bootstrap-modal.js'
  ],
  sources: [
    'dist/bootstrap-dialogs.js'
  ],
  tests: [
    'dist/bootstrap-dialogs-test.js'
  ]
};
