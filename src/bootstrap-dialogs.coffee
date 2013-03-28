$ = this.jQuery
Bootstrap = this.Bootstrap or= {}


mkbutton = (text, isPrimary) ->
  primary = if isPrimary then 'btn-primary' else ''
  $("""
    <button type="button" class="btn #{primary}">#{text}</button>
  """)


exports = Bootstrap.Dialogs =

  alert: (title='Alert', body) ->
    promise = exports.dialog(title, body, [
      [ mkbutton('Ok', true), -> promise.resolve() ]
    ])

  confirm: (title='Please confirm', body) ->
    promise = exports.dialog(title, body, [
      [ 'Cancel', -> promise.reject() ]
      [ mkbutton('Ok', true), -> promise.resolve() ]
    ])

  dialog: (title, body, buttons=[]) ->
    title = $('<h3>').html(title)

    $closeButton = $('''
      <button type="button" class="close" data-dismiss="modal"
        aria-hidden="true">&times;</button>
    ''')

    body =
      if body
        $('<div class="modal-body">').html(body)
      else
        ''

    buttons = for button in buttons
      if button instanceof Array
        handler = button[1]
        button = button[0]

      if typeof button is 'string'
        $btn = $('<button type="button" class="btn">').html(button)
      else
        $btn = $(button)

      $btn.click(handler) if handler instanceof Function
      $btn

    $el = $('<div class="modal hide fade">').html([
      $('<div class="modal-header">').html([
        $closeButton
        title
      ])
      body
      $('<div class="modal-footer">').html(buttons)
    ])

    promise = $.Deferred()
    promise.el = $el[0]
    promise.$el = $el

    promise.always ->
      $el.modal('hide')
      $el.remove()

    $closeButton.click(-> promise.reject())

    $el.modal(backdrop: 'static')
    promise

  prompt: (title='Please enter a value', body='') ->
    resolve = -> promise.resolve($input.val())
    reject = -> promise.reject()
    keypress = (e) -> resolve() if e.which is 13

    $input = $('<input type="text">').keypress(keypress)

    promise = exports.dialog(title, [ body, $input ], [
      [ 'Cancel', reject ]
      [ mkbutton('Ok', true), resolve ]
    ])

    $input.focus()
    promise.$input = $input
    promise
