$ = this.jQuery
Bootstrap = this.Bootstrap or= {}


exports = Bootstrap.Dialog =

  alert: (title) ->
    exports.dialog(title)

  confirm: (title) ->
    exports.dialog(title)

  dialog: ->
    $.Deferred()

  prompt: (title) ->
    exports.dialog(title)
