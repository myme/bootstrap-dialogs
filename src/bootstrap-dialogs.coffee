$ = this.jQuery
Bootstrap = this.Bootstrap or= {}


exports = Bootstrap.Dialogs =

  alert: (title='Alert', body) ->
    promise = exports.dialog(title, body, [
      [ 'Ok', -> promise.resolve() ]
    ])

  confirm: (title='Please confirm', body) ->
    promise = exports.dialog(title, body, [
      [ 'Cancel', -> promise.reject() ]
      [ 'Ok', -> promise.resolve() ]
    ])

  dialog: (title, body, buttons=[]) ->
    title = $('<h3>').html(title)

    body =
      if body
        $('<div class="modal-body">').html(body)
      else
        ''

    buttons = for button in buttons
      if typeof button is 'string'
        text = button
        handler = null
      else
        text = button[0]
        handler = button[1]
      $btn = $('<button class="btn">').html(text)
      $btn.click(handler) if handler instanceof Function
      $btn

    $el = $('<div class="modal hide fade">').html([
      $('<div class="modal-header">').html(title)
      body
      $('<div class="modal-footer">').html(buttons)
    ])

    promise = $.Deferred()
    promise.el = $el[0]
    promise.$el = $el

    promise.always ->
      $el.modal('hide')
      $el.remove()

    $el.modal(backdrop: 'static')
    promise

  prompt: (title='Please enter a value', body='') ->
    resolve = -> promise.resolve($input.val())
    reject = -> promise.reject()
    keypress = (e) -> resolve() if e.which is 13

    $input = $('<input type="text">').keypress(keypress)

    promise = exports.dialog(title, [ body, $input ], [
      [ 'Cancel', reject ]
      [ 'Ok', resolve ]
    ])

    $input.focus()
    promise.$input = $input
    promise
