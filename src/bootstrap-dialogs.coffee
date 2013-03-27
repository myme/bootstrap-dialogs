$ = this.jQuery
Bootstrap = this.Bootstrap or= {}


exports = Bootstrap.Dialogs =

  alert: (title) ->
    exports.dialog(title)

  confirm: (title) ->
    exports.dialog(title)

  dialog: (title) ->
    html = """
      <div class="modal hide fade">
        <div class="modal-header">
          #{title}
        </div>
        <div class="modal-body">
        </div>
        <div class="modal-footer">
        </div>
      </div>
    """

    promise = $.Deferred()
    promise.el = $(html)[0]
    promise

  prompt: (title) ->
    exports.dialog(title)
