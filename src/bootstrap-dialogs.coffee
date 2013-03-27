$ = this.jQuery
Bootstrap = this.Bootstrap or= {}


exports = Bootstrap.Dialogs =

  alert: (title='Alert') ->
    exports.dialog(title)

  confirm: (title='Please confirm') ->
    exports.dialog(title)

  dialog: (title) ->
    $el = $("""
      <div class="modal hide fade">
        <div class="modal-header">
          #{title}
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
        </div>
      </div>
    """)

    promise = $.Deferred()
    promise.el = $el[0]
    promise.$el = $el

    $el.modal('show')

    promise

  prompt: (title='Please enter a value') ->
    exports.dialog(title)
