$ = this.jQuery
Bootstrap = this.Bootstrap
{alert, confirm, dialog, prompt} = Bootstrap.Dialog


buster = this.buster
assert = buster.assert
refute = buster.refute


buster.testCase 'Bootstrap.Dialog',

  setUp: ->
    @dialogSpy = @spy(Bootstrap.Dialog, 'dialog')

  'alert':

    'is a function': ->
      assert.isFunction(alert)

    'calls .dialog': ->
      alert()
      assert.calledOnce(@dialogSpy)

    'calls .dialog with title': ->
      alert('Foobar')
      assert.calledOnceWith(@dialogSpy, 'Foobar')

    'returns same as .dialog': ->
      promise = alert()
      assert(@dialogSpy.returned(promise))

  'confirm':

    'is a function': ->
      assert.isFunction(confirm)

    'calls .dialog': ->
      confirm()
      assert.calledOnce(@dialogSpy)

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

  'prompt':

    'is a function': ->
      assert.isFunction(prompt)

    'calls .dialog': ->
      prompt()
      assert.calledOnce(@dialogSpy)

    'calls .dialog with title': ->
      prompt('Foobar')
      assert.calledOnceWith(@dialogSpy, 'Foobar')

    'returns same as .dialog': ->
      promise = prompt()
      assert(@dialogSpy.returned(promise))
