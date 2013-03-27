$ = this.jQuery
Bootstrap = this.Bootstrap or= {}


exports = Bootstrap.Dialogs =

  alert: (title) ->
    exports.dialog(title)

  confirm: (title) ->
    exports.dialog(title)

  dialog: ->
    promise = $.Deferred()
    promise.el = $('<div>')[0]
    promise

  prompt: (title) ->
    exports.dialog(title)
