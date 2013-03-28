(function() {
  var $, Bootstrap, exports, mkbutton, normalizeButtons;

  $ = this.jQuery;

  Bootstrap = this.Bootstrap || (this.Bootstrap = {});

  mkbutton = function(text, isPrimary) {
    var $btn;

    $btn = $('<button type="button" class="btn">').html(text);
    if (isPrimary) {
      $btn.addClass('btn-primary');
    }
    return $btn;
  };

  normalizeButtons = function(buttons) {
    var $btn, button, handler, _i, _len, _results;

    _results = [];
    for (_i = 0, _len = buttons.length; _i < _len; _i++) {
      button = buttons[_i];
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

  exports = Bootstrap.Dialogs = {
    alert: function(title, body) {
      var promise;

      if (title == null) {
        title = 'Alert';
      }
      return promise = exports.dialog(title, body, [
        [
          mkbutton('Ok', true), function() {
            return promise.resolve();
          }
        ]
      ]);
    },
    confirm: function(title, body) {
      var promise;

      if (title == null) {
        title = 'Please confirm';
      }
      return promise = exports.dialog(title, body, [
        [
          'Cancel', function() {
            return promise.reject();
          }
        ], [
          mkbutton('Ok', true), function() {
            return promise.resolve();
          }
        ]
      ]);
    },
    dialog: function(title, body, buttons) {
      var $closeButton, $el, promise;

      if (buttons == null) {
        buttons = [];
      }
      $closeButton = $('<button type="button" class="close" data-dismiss="modal"\n  aria-hidden="true">&times;</button>');
      $el = $('<div class="modal hide fade">').html([$('<div class="modal-header">').html([$closeButton, $('<h3>').html(title)]), body ? $('<div class="modal-body">').html(body) : '', $('<div class="modal-footer">').html(normalizeButtons(buttons))]);
      promise = $.Deferred();
      promise.el = $el[0];
      promise.$el = $el;
      promise.always(function() {
        $el.modal('hide');
        return $el.remove();
      });
      $closeButton.click(function() {
        return promise.reject();
      });
      $el.modal({
        backdrop: 'static'
      });
      return promise;
    },
    prompt: function(title, body) {
      var $input, keypress, promise, reject, resolve;

      if (title == null) {
        title = 'Please enter a value';
      }
      if (body == null) {
        body = '';
      }
      resolve = function() {
        return promise.resolve($input.val());
      };
      reject = function() {
        return promise.reject();
      };
      keypress = function(e) {
        if (e.which === 13) {
          return resolve();
        }
      };
      $input = $('<input type="text">').keypress(keypress);
      promise = exports.dialog(title, [body, $input], [['Cancel', reject], [mkbutton('Ok', true), resolve]]);
      $input.focus();
      promise.$input = $input;
      return promise;
    }
  };

}).call(this);
