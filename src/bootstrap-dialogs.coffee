$ = this.jQuery
Bootstrap = this.Bootstrap or= {}


exports = Bootstrap.Dialogs =

  alert: (title='Alert', body) ->
    exports.dialog(title, body, [
      'Ok'
    ])

  confirm: (title='Please confirm', body) ->
    exports.dialog(title, body, [
      'Cancel'
      'Ok'
    ])

  dialog: (title, body, buttons=[]) ->
    body =
      if body
        """<div class="modal-body">#{body}</div>"""
      else
        ''

    buttons = (for button in buttons
      """<button class="btn">#{button}</button>"""
    ).join(' ')

    $el = $("""
      <div class="modal hide fade">
        <div class="modal-header">
          #{title}
        </div>
        #{body}
        <div class="modal-footer">
          #{buttons}
        </div>
      </div>
    """)

    promise = $.Deferred()
    promise.el = $el[0]
    promise.$el = $el

    $el.modal('show')

    promise

  prompt: (title='Please enter a value', body) ->
    exports.dialog(title, body, [
      'Cancel'
      'Ok'
    ])
