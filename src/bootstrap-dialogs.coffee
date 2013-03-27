Bootstrap = this.Bootstrap or= {}


exports = Bootstrap.Dialog =

  alert: (title) ->
    exports.dialog(title)

  confirm: (title) ->
    exports.dialog(title)

  dialog: ->

  prompt: (title) ->
    exports.dialog(title)
