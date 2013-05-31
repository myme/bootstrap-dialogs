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
    defaultOptions =
      title: 'Alert'
      ok: 'Ok'
      danger: false
    options = $.extend(defaultOptions, options)

    okClass = if options.danger then 'danger' else 'primary'
    promise = exports.dialog
      title: options.title
      body: options.body
      buttons: [
        [ mkbutton(options.ok, okClass), -> promise.resolve() ]
      ]

    returnHandler = (e) -> promise.resolve() if e.which is RETURN
    $('body').on('keyup', returnHandler)
    promise.always ->
      $('body').off('keyup', returnHandler)

  confirm: (options={}) ->
    defaultOptions =
      title: 'Please confirm'
      ok: 'Ok'
      cancel: 'Cancel'
      danger: false
    options = $.extend(defaultOptions, options)

    okClass = if options.danger then 'danger' else 'primary'

    promise = exports.dialog
      title: options.title
      body: options.body
      buttons: [
        [ options.cancel, -> promise.reject() ]
        [ mkbutton(options.ok, okClass), -> promise.resolve() ]
      ]

    if options.return
      returnHandler = (e) -> promise.resolve() if e.which is RETURN
      $('body').on('keyup', returnHandler)
      promise.always ->
        $('body').off('keyup', returnHandler)

    promise

  dialog: (options={}) ->
    title = options.title
    body = options.body
    buttons = options.buttons or []

    titleEls = [ $('<h3>').html(title) ]
    if not options.lock
      $closeButton = $('''
        <button type="button" class="close" data-dismiss="modal"
          aria-hidden="true">&times;</button>
      ''')
      titleEls.unshift($closeButton)

    $el = $('<div class="modal hide fade">').html([
      $('<div class="modal-header">').html(titleEls)
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

    if not options.lock
      escHandler = (e) -> promise.reject() if e.which is ESC

    promise.always ->
      $('body').off('keyup', escHandler) if escHandler
      $el.modal('hide')
      $el.remove()

    $closeButton?.click(-> promise.reject())
    $('body').on('keyup', escHandler) if escHandler

    if options.lock
      $el.modal(backdrop: 'static')
    else
      $el.modal()
    promise

  prompt: (options={}) ->
    defaultOptions =
      title: 'Please enter a value'
      body: ''
      ok: 'Ok'
      cancel: 'Cancel'
    options = $.extend(defaultOptions, options)

    okClass = if options.danger then 'danger' else 'primary'

    resolve = -> promise.resolve($input.val())
    reject = -> promise.reject()
    keyup = (e) -> resolve() if e.which is RETURN

    $input = $('<input type="text">')

    promise = exports.dialog
      title: options.title
      body: [ options.body, $input ]
      buttons: [
        [ options.cancel, reject ]
        [ mkbutton(options.ok, okClass), resolve ]
      ]

    $('body').on('keyup', keyup)
    promise.always ->
      $('body').off('keyup', keyup)

    $input.focus()
    promise.$input = $input
    promise
