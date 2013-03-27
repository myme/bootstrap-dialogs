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

License
-------

Distrubuted under the [ISC][ISC] license.  Please refer to the
[LICENSE](LICENSE-ISC).

[ISC]: http://en.wikipedia.org/wiki/ISC_license
