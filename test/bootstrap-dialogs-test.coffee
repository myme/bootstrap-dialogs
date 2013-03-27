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

  'confirm':

    'is a function': ->
      assert.isFunction(confirm)

    'calls .dialog': ->
      confirm()
      assert.calledOnce(@dialogSpy)

    'calls .dialog with title': ->
      confirm('Foobar')
      assert.calledOnceWith(@dialogSpy, 'Foobar')

  'dialog':

    'is a function': ->
      assert.isFunction(dialog)

  'prompt':

    'is a function': ->
      assert.isFunction(prompt)

    'calls .dialog': ->
      prompt()
      assert.calledOnce(@dialogSpy)

    'calls .dialog with title': ->
      prompt('Foobar')
      assert.calledOnceWith(@dialogSpy, 'Foobar')
