(function() {
  var $, Bootstrap, ESC, RETURN, exports, mkbutton, module, normalizeButtons;

  if (typeof require !== "undefined" && require !== null) {
    $ = require('jquery');
    Bootstrap = require('bootstrap');
  } else {
    $ = this.jQuery;
    Bootstrap = this.Bootstrap || (this.Bootstrap = {});
  }

  if (typeof module === "undefined" || module === null) {
    module = {
      exports: exports = {}
    };
    Bootstrap.Dialogs = exports;
  }

  RETURN = 13;

  ESC = 27;

  mkbutton = function(text, btnClass) {
    var $btn;
    $btn = $('<button type="button" class="btn">').html(text);
    if (btnClass) {
      $btn.addClass("btn-" + btnClass);
    }
    return $btn;
  };

  normalizeButtons = function(buttons) {
    var $btn, button, handler, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = buttons.length; _i < _len; _i++) {
      button = buttons[_i];
      handler = null;
      if (button instanceof Array) {
        handler = button[1];
        button = button[0];
      }
      if (typeof button === 'string') {
        $btn = mkbutton(button);
      } else {
        $btn = $(button);
      }
      if (handler instanceof Function) {
        $btn.click(handler);
      }
      _results.push($btn);
    }
    return _results;
  };

  exports.alert = function(options) {
    var defaultOptions, okClass, promise, returnHandler;
    if (options == null) {
      options = {};
    }
    defaultOptions = {
      title: 'Alert',
      ok: 'OK',
      lock: true,
      danger: false
    };
    options = $.extend(defaultOptions, options);
    okClass = options.danger ? 'danger' : 'primary';
    promise = exports.dialog({
      title: options.title,
      body: options.body,
      lock: options.lock,
      buttons: [
        [
          mkbutton(options.ok, okClass), function() {
            return promise.resolve();
          }
        ]
      ]
    });
    returnHandler = function(e) {
      if (e.which === RETURN) {
        return promise.resolve();
      }
    };
    $('body').on('keyup', returnHandler);
    return promise.always(function() {
      return $('body').off('keyup', returnHandler);
    });
  };

  exports.confirm = function(options) {
    var defaultOptions, okClass, promise, returnHandler;
    if (options == null) {
      options = {};
    }
    defaultOptions = {
      title: 'Please confirm',
      ok: 'OK',
      cancel: 'Cancel',
      danger: false
    };
    options = $.extend(defaultOptions, options);
    okClass = options.danger ? 'danger' : 'primary';
    promise = exports.dialog({
      title: options.title,
      body: options.body,
      buttons: [
        [
          options.cancel, function() {
            return promise.reject();
          }
        ], [
          mkbutton(options.ok, okClass), function() {
            return promise.resolve();
          }
        ]
      ]
    });
    if (options["return"]) {
      returnHandler = function(e) {
        if (e.which === RETURN) {
          return promise.resolve();
        }
      };
      $('body').on('keyup', returnHandler);
      promise.always(function() {
        return $('body').off('keyup', returnHandler);
      });
    }
    return promise;
  };

  exports.dialog = function(options) {
    var $closeButton, $el, body, buttons, escHandler, promise, title, titleEls;
    if (options == null) {
      options = {};
    }
    title = options.title;
    body = options.body;
    buttons = options.buttons || [];
    titleEls = [$('<h3>').html(title)];
    if (!options.lock) {
      $closeButton = $('<button type="button" class="close" data-dismiss="modal"\n  aria-hidden="true">&times;</button>');
      titleEls.unshift($closeButton);
    }
    $el = $('<div class="modal hide fade">').html([$('<div class="modal-header">').html(titleEls), body ? $('<div class="modal-body">').html(body) : '', $('<div class="modal-footer">').html(normalizeButtons(buttons))]);
    promise = $.Deferred();
    promise.el = $el[0];
    promise.$el = $el;
    $el.on('hidden', function() {
      if (promise.state() === 'pending') {
        return promise.reject();
      }
    });
    if (!options.lock) {
      escHandler = function(e) {
        if (e.which === ESC) {
          return promise.reject();
        }
      };
    }
    promise.always(function() {
      exports.enableScrolling();
      if (escHandler) {
        $('body').off('keyup', escHandler);
      }
      $el.modal('hide');
      return $el.remove();
    });
    if (escHandler) {
      $('body').on('keyup', escHandler);
    }
    if (options.lock) {
      $el.modal({
        backdrop: 'static',
        keyboard: false
      });
    } else {
      $el.modal({
        keyboard: false
      });
    }
    exports.disableScrolling();
    return promise;
  };

  exports.disableScrolling = function() {
    $('html').css({
      position: 'fixed',
      top: -Math.abs($(window.document).scrollTop()),
      width: '100%'
    });
    return void 0;
  };

  exports.enableScrolling = function() {
    var offset;
    offset = Math.abs(parseInt($('html').css('top')));
    $('html').css({
      position: 'static',
      top: 'auto'
    });
    $(window.document).scrollTop(offset);
    return void 0;
  };

  exports.prompt = function(options) {
    var $input, defaultOptions, keyup, okClass, promise, reject, resolve;
    if (options == null) {
      options = {};
    }
    defaultOptions = {
      title: 'Please enter a value',
      body: '',
      ok: 'OK',
      cancel: 'Cancel'
    };
    options = $.extend(defaultOptions, options);
    okClass = options.danger ? 'danger' : 'primary';
    resolve = function() {
      return promise.resolve($input.val());
    };
    reject = function() {
      return promise.reject();
    };
    keyup = function(e) {
      if (e.which === RETURN) {
        return resolve();
      }
    };
    $input = $('<input type="text">');
    promise = exports.dialog({
      title: options.title,
      body: [options.body, $input],
      buttons: [[options.cancel, reject], [mkbutton(options.ok, okClass), resolve]]
    });
    $('body').on('keyup', keyup);
    promise.always(function() {
      return $('body').off('keyup', keyup);
    });
    $input.focus();
    promise.$input = $input;
    return promise;
  };

}).call(this);
