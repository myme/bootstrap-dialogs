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

    'calls .dialog with title and body': ->
      alert('Title', 'Body')
      assert.calledOnceWith(@dialogSpy, 'Title', 'Body')

    'returns same as .dialog': ->
      assert(@dialogSpy.returned(alert()))

    'creates modal with one "Ok" button': ->
      $btn = alert().$el.find('button')
      assert.equals($btn.length, 1)
      assert.equals($btn.text(), 'Ok')

  'confirm':

    'is a function': ->
      assert.isFunction(confirm)

    'calls .dialog with default title': ->
      confirm()
      assert.calledOnceWith(@dialogSpy, 'Please confirm')

    'calls .dialog with title and body': ->
      confirm('Title', 'Body')
      assert.calledOnceWith(@dialogSpy, 'Title', 'Body')

    'returns same as .dialog': ->
      assert(@dialogSpy.returned(confirm()))

    'creates modal with "Cancel" and "Ok" button': ->
      $buttons = confirm().$el.find('button')
      assert.equals($buttons.length, 2)
      assert.match($buttons.text(), 'Cancel')
      assert.match($buttons.text(), 'Ok')

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

    'does not add a body if undefined': ->
      assert.equals(
        dialog('Title').$el.find('.modal-body').length, 0)

    'adds buttons': ->
      $el = dialog('Title', 'Body', [
        'Cancel', 'Ok'
      ]).$el
      $buttons = $el.find('button')
      assert.equals($buttons.length, 2)
      assert.match($buttons.text(), 'Cancel')
      assert.match($buttons.text(), 'Ok')

    'adds handlers to buttons': ->
      spy = @spy()
      dialog('Title', 'Body', [[ 'Ok', spy ]])
        .$el
        .find('button')
        .click()
      assert.calledOnce(spy)

    'adds body to modal element': ->
      assert.match(
        dialog('Foo Title', 'Bar Body').el
        innerHTML: 'Bar Body')

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

    'calls .dialog with title and body': ->
      prompt('Title', 'Body')
      assert.calledOnceWith(@dialogSpy, 'Title', 'Body')

    'returns same as .dialog': ->
      assert(@dialogSpy.returned(prompt()))

    'creates modal with "Cancel" and "Ok" buttons': ->
      $buttons = prompt().$el.find('button')
      assert.equals($buttons.length, 2)
      assert.match($buttons.text(), 'Cancel')
      assert.match($buttons.text(), 'Ok')
