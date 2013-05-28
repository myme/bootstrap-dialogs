$ = this.jQuery
Bootstrap = this.Bootstrap or= {}


RETURN = 13
ESC = 27


mkbutton = (text, btnClass) ->
  $btn = $('<button type="button" class="btn">').html(text)
  $btn.addClass("btn-#{btnClass}") if btnClass
  $btn


normalizeButtons = (buttons) ->
  for button in buttons
    if button instanceof Array
      handler = button[1]
      button = button[0]

    if typeof button is 'string'
      $btn = mkbutton(button)
    else
      $btn = $(button)

    $btn.click(handler) if handler instanceof Function
    $btn


exports = Bootstrap.Dialogs =

  alert: (options={}) ->
    title = options.title or 'Alert'
    body = options.body
    okText = options.ok or 'Ok'
    okClass = if options.danger then 'danger' else 'primary'
    promise = exports.dialog
      title: title
      body: body
      buttons: [
        [ mkbutton(okText, okClass), -> promise.resolve() ]
      ]
    returnHandler = (e) -> promise.resolve() if e.which is RETURN
    $('body').on('keyup', returnHandler)
    promise.always ->
      $('body').off('keyup', returnHandler)

  confirm: (options={}) ->
    title = options.title or 'Please confirm'
    body = options.body
    okText = options.ok or 'Ok'
    okClass = if options.danger then 'danger' else 'primary'
    cancelText = options.cancel or 'Cancel'
    promise = exports.dialog
      title: title
      body: body
      buttons: [
        [ cancelText, -> promise.reject() ]
        [ mkbutton(okText, okClass), -> promise.resolve() ]
      ]

  dialog: (title, body, buttons=[]) ->
    if typeof title is 'object'
      body = title.body
      buttons = title.buttons or []
      title = title.title

    $closeButton = $('''
      <button type="button" class="close" data-dismiss="modal"
        aria-hidden="true">&times;</button>
    ''')

    $el = $('<div class="modal hide fade">').html([
      $('<div class="modal-header">').html([
        $closeButton
        $('<h3>').html(title)
      ])
      if body
        $('<div class="modal-body">').html(body)
      else
        ''
      $('<div class="modal-footer">').html(
        normalizeButtons(buttons)
      )
    ])

    promise = $.Deferred()
    promise.el = $el[0]
    promise.$el = $el

    escHandler = (e) -> promise.reject() if e.which is ESC

    promise.always ->
      $('body').off('keyup', escHandler)
      $el.modal('hide')
      $el.remove()

    $closeButton.click(-> promise.reject())
    $('body').on('keyup', escHandler)

    $el.modal(backdrop: 'static')
    promise

  prompt: (options={}) ->
    title = options.title or 'Please enter a value'
    body = options.body or ''
    okText = options.ok or 'Ok'
    okClass = if options.danger then 'danger' else 'primary'
    cancelText = options.cancel or 'Cancel'

    resolve = -> promise.resolve($input.val())
    reject = -> promise.reject()
    keyup = (e) -> resolve() if e.which is RETURN

    $input = $('<input type="text">')

    promise = exports.dialog
      title: title
      body: [ body, $input ]
      buttons: [
        [ cancelText, reject ]
        [ mkbutton(okText, okClass), resolve ]
      ]

    $('body').on('keyup', keyup)
    promise.always ->
      $('body').off('keyup', keyup)

    $input.focus()
    promise.$input = $input
    promise
