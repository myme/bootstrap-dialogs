Bootstrap Dialogs
=================

[![Latest npm version](https://img.shields.io/npm/v/bootstrap-dialogs.svg?style=flat)](https://www.npmjs.org/package/bootstrap-dialogs)
[![Number of npm downloads](https://img.shields.io/npm/dm/bootstrap-dialogs.svg?style=flat)](https://www.npmjs.org/package/bootstrap-dialogs)
[![Build Status](https://img.shields.io/travis/myme/bootstrap-dialogs.svg?style=flat)](https://travis-ci.org/myme/bootstrap-dialogs)

Description
-----------

Asynchronous modal dialogs for the synchronous `window.alert`, `window.confirm`
and `window.prompt`, styled and managed by [Twitter Bootstrap][bootstrap].
Pretty similar to [Bootbox](http://bootboxjs.com/), yet using
[jQuery](http://jquery.com)'s Deferred objects.

[bootstrap]: http://twitter.github.com/bootstrap

Usage
-----

`alert`, `confirm` and `prompt` all support custom title and body. Additionally,
they support setting the button text and severity (default and danger at the moment).

```javascript
// Alert dialog with custom title and body
Bootstrap.Dialogs.alert({ title: 'Alert title', body: 'Alert body' })
  .done(function () {
    ...
  });

// Confirm dialog with default text
Bootstrap.Dialogs.confirm()
  .done(function () {
    ...
  })
  .fail(function () {
    ...
  });

// Prompt dialog with custom title and body
Bootstrap.Dialogs.prompt({ title: 'What is your name?', body: 'Please enter your name' })
  .done(function (name) {
    ...
  })
  .fail(function () {
    ...
  });
  
// Confirm dialog with custom button text
Bootstrap.Dialogs.confirm({ ok: 'Confirm', cancel: 'Abort' });
  
// Critical alert dialog
Bootstrap.Dialogs.alert({ danger: true });
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

Perform release
---------------

  * Update `Release notes`
  * Bump `package.json` and `bower.json` version numbers
  * Run `npm run dist` to update all distribution sources
  * `git tag -a <tag>` with the appropriate version number</tag>

Release notes
-------------

### v0.3.0 (2015-05-28)

 * Add very basic CommonJS support.

### v0.2.8 (2014-05-06)

 * Fix leak of click handlers between buttons.

### v0.2.7 (2014-02-25)

 * Disable scrolling of body behind a dialog.

### v0.2.6

 * Upgrade jQuery dependency to 1.10.2.
 * Capitalize "OK" texts.

### v0.2.5

 * Make Bower dependencies looser.

### v0.2.4

 * Fix #5: Allow clicking the backdrop to dismiss (unless "lock" is true).
 * Fix #4: Add "lock" option to disable ESC closing.
 * Replace `noButtons` with `lock` option.

### v0.2.3

 * Remove positional arguments support from .dialog.
 * Add `noButtons` option to .dialog.

### v0.2.2

 * Add `return` option to allow confirm dialogs to optionally be
   resolvable by pressing the return key.

### v0.2.1

 * Fix #3: Allow setting alert, confirm and prompt button texts.

### v0.2.0

 * Update API's argument passing style to be objects rather
   than regular argument list.
 * Fix #2: Add option to make the 'OK' button take on the btn-danger class.

### v0.1.0

 * Add keyboard bindings for Return and Escape

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
