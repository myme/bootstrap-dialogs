(function() {
  var $, Bootstrap, exports;

  $ = this.jQuery;

  Bootstrap = this.Bootstrap || (this.Bootstrap = {});

  exports = Bootstrap.Dialogs = {
    alert: function(title, body) {
      var promise;

      if (title == null) {
        title = 'Alert';
      }
      return promise = exports.dialog(title, body, [
        [
          'Ok', function() {
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
          'Ok', function() {
            return promise.resolve();
          }
        ]
      ]);
    },
    dialog: function(title, body, buttons) {
      var $btn, $closeButton, $el, button, handler, promise, text;

      if (buttons == null) {
        buttons = [];
      }
      title = $('<h3>').html(title);
      $closeButton = $('<button type="button" class="close" data-dismiss="modal"\n  aria-hidden="true">&times;</button>');
      body = body ? $('<div class="modal-body">').html(body) : '';
      buttons = (function() {
        var _i, _len, _results;

        _results = [];
        for (_i = 0, _len = buttons.length; _i < _len; _i++) {
          button = buttons[_i];
          if (typeof button === 'string') {
            text = button;
            handler = null;
          } else {
            text = button[0];
            handler = button[1];
          }
          $btn = $('<button type="button" class="btn">').html(text);
          if (handler instanceof Function) {
            $btn.click(handler);
          }
          _results.push($btn);
        }
        return _results;
      })();
      $el = $('<div class="modal hide fade">').html([$('<div class="modal-header">').html([$closeButton, title]), body, $('<div class="modal-footer">').html(buttons)]);
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
      promise = exports.dialog(title, [body, $input], [['Cancel', reject], ['Ok', resolve]]);
      $input.focus();
      promise.$input = $input;
      return promise;
    }
  };

}).call(this);
