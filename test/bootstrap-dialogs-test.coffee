$ = this.jQuery
Bootstrap = this.Bootstrap
{alert, confirm, dialog, prompt} = Bootstrap.Dialogs


buster = this.buster
assert = buster.assert
refute = buster.refute


buster.testCase 'Bootstrap.Dialog',

  setUp: ->
    @dialogSpy = @spy(Bootstrap.Dialogs, 'dialog')

  'alert':

    'is a function': ->
      assert.isFunction(alert)

    'calls .dialog with default title': ->
      alert()
      assert.calledOnceWith(@dialogSpy, 'Alert')

    'calls .dialog with title': ->
      alert('Foobar')
      assert.calledOnceWith(@dialogSpy, 'Foobar')

    'returns same as .dialog': ->
      promise = alert()
      assert(@dialogSpy.returned(promise))

  'confirm':

    'is a function': ->
      assert.isFunction(confirm)

    'calls .dialog with default title': ->
      confirm()
      assert.calledOnceWith(@dialogSpy, 'Please confirm')

    'calls .dialog with title': ->
      confirm('Foobar')
      assert.calledOnceWith(@dialogSpy, 'Foobar')

    'returns same as .dialog': ->
      promise = confirm()
      assert(@dialogSpy.returned(promise))

  'dialog':

    'is a function': ->
      assert.isFunction(dialog)

    'returns a promise with .then': ->
      assert.isFunction(dialog().then)

    'returns a promise with .done': ->
      assert.isFunction(dialog().done)

    'returns a promise with .fail': ->
      assert.isFunction(dialog().fail)

    'promise holds reference to jquery modal': ->
      assert.tagName(dialog().$el[0], 'div')

    'promise holds reference to modal': ->
      promise = dialog()
      assert.same(promise.el, promise.$el[0])

    'element has modal class': ->
      assert.className(dialog().el, 'modal')

    'adds title to modal element': ->
      assert.match(dialog('Foobar').el, innerHTML: 'Foobar')

    'calls $.fn.modal on proper element': ->
      spy = @spy($.fn, 'modal')
      $el = dialog().$el
      assert.calledOn(spy, $el)

  'prompt':

    'is a function': ->
      assert.isFunction(prompt)

    'calls .dialog with default title': ->
      prompt()
      assert.calledOnceWith(@dialogSpy, 'Please enter a value')

    'calls .dialog with title': ->
      prompt('Foobar')
      assert.calledOnceWith(@dialogSpy, 'Foobar')

    'returns same as .dialog': ->
      promise = prompt()
      assert(@dialogSpy.returned(promise))
