[![Build Status](https://travis-ci.org/myme/bootstrap-dialogs.png?branch=master)](https://travis-ci.org/myme/bootstrap-dialogs)

Bootstrap Dialogs
=================

Description
-----------

Asynchronous modal dialogs for the synchronous `window.alert`, `window.confirm`
and `window.prompt`, styled and managed by [Twitter Bootstrap][bootstrap].
Pretty similar to [Bootbox](http://bootboxjs.com/), yet using
[jQuery](http://jquery.com)'s Deferred objects.

[bootstrap]: http://twitter.github.com/bootstrap

Usage
-----

```javascript
Bootstrap.Dialog.alert('Alert title', 'Alert body')
  .done(function () {
    ...
  });

Bootstrap.Dialog.confirm()
  .done(function () {
    ...
  })
  .fail(function () {
    ...
  });

Bootstrap.Dialog.prompt('What is your name?', 'Please enter your name')
  .done(function (name) {
    ...
  })
  .fail(function () {
    ...
  });
```

Development
-----------

TL;DR: `npm install && npm test`

Install [Node](http://nodejs.org) and [Npm](http://npmjs.org) using your packet
manager of choice.

Install development dependencies:

    npm install

Build and run the tests:

    npm test

Start a development cycle listening for changes to files running a simple
static server, CoffeeScript linting + compilation, and the test suite:

    npm start

Examples
--------

To see the examples in action, issue `npm install && npm start` and access
[http://localhost:8000/examples/](http://localhost:8000/examples/).

Upgrade the distribution files
------------------------------

In order to upgrade the distribution files bundled in the repo, run `npm run-script dist`.

Release notes
-------------

### v0.0.3

 * Add grunt-cli as a dependency
 * Depend on jQuery 1.8.3 to match Bootstrap
 * Allow buttons to be jQuery objects or DOM elements
 * Make "Ok" buttons primary

### v0.0.2

 * Add Bootstrap and jQuery as component dependencies.
 * Submit prompt on Return keypress.
 * Give prompt input focus.
 * Wrap titles in h3.
 * Add close button by default.

### v0.0.1

 * Initial release.

License
-------

Distrubuted under the [ISC][ISC] license.  Please refer to the
[LICENSE](LICENSE-ISC).

[ISC]: http://en.wikipedia.org/wiki/ISC_license
