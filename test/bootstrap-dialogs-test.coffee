$ = this.jQuery
Bootstrap = this.Bootstrap
{alert, confirm, dialog, prompt} = Bootstrap.Dialogs


buster = this.buster
assert = buster.assert
refute = buster.refute


RETURN = 13
ESC = 27


triggerKey = (which, el='body') ->
  event = $.Event('keyup')
  event.which = which
  $(el).trigger(event)


buster.testCase 'Bootstrap.Dialog',

  setUp: ->
    @dialogSpy = @spy(Bootstrap.Dialogs, 'dialog')

  'alert':

    'is a function': ->
      assert.isFunction(alert)

    'calls .dialog with default title': ->
      alert()
      assert.match(@dialogSpy.args[0][0], title: 'Alert')

    'calls .dialog with title and body': ->
      alert(title: 'Title', body: 'Body')
      assert.match(@dialogSpy.args[0][0], title: 'Title', body: 'Body')

    'returns same as .dialog': ->
      assert(@dialogSpy.returned(alert()))

    'creates modal with one "Ok" button': ->
      $btn = alert().$el.find('button.btn')
      assert.equals($btn.length, 1)
      assert.equals($btn.text(), 'Ok')

    '"Ok" button has class btn-primary': ->
      $btn = alert().$el.find('button.btn')
      assert.className($btn[0], 'btn-primary')

    'danger options gives "Ok" button btn-danger class': ->
      $btn = alert(danger: true).$el.find('button.btn')
      assert.className($btn[0], 'btn-danger')

    'clicking button triggers .resolve': ->
      promise = alert()
      spy = @spy(promise, 'resolve')
      promise.$el.find('button.btn').click()
      assert.calledOnce(spy)

    'pressing Return closes the modal as success': ->
      spy = @spy()
      promise = alert().done(spy)
      triggerKey(RETURN)
      assert.calledOnce(spy)

    '.reject removes Return key handler from body': ->
      promise = alert().reject()
      spy = @spy(promise, 'resolve')
      triggerKey(RETURN)
      refute.called(spy)

    '.resolve removes ESC key handler from body': ->
      promise = alert().resolve()
      spy = @spy(promise, 'resolve')
      triggerKey(RETURN)
      refute.called(spy)

  'confirm':

    'is a function': ->
      assert.isFunction(confirm)

    'calls .dialog with default title': ->
      confirm()
      assert.match(@dialogSpy.args[0][0], title: 'Please confirm')

    'calls .dialog with title and body': ->
      confirm(title: 'Title', body: 'Body')
      assert.match(@dialogSpy.args[0][0], title: 'Title', body: 'Body')

    'returns same as .dialog': ->
      assert(@dialogSpy.returned(confirm()))

    'creates modal with "Cancel" and "Ok" button': ->
      $buttons = confirm().$el.find('button.btn')
      assert.equals($buttons.length, 2)
      assert.match($buttons.text(), 'Cancel')
      assert.match($buttons.text(), 'Ok')

    '"Ok" button has class btn-primary': ->
      $btn = confirm().$el.find('button.btn:contains("Ok")')
      assert.className($btn[0], 'btn-primary')

    'danger options gives "Ok" button btn-danger class': ->
      $btn = confirm(danger: true).$el.find('button.btn:contains("Ok")')
      assert.className($btn[0], 'btn-danger')

    'clicking "Ok" button triggers .resolve': ->
      promise = confirm()
      spy = @spy(promise, 'resolve')
      promise.$el.find('button:contains("Ok")').click()
      assert.calledOnce(spy)

    'clicking "Cancel" button triggers .reject': ->
      promise = confirm()
      spy = @spy(promise, 'reject')
      promise.$el.find('button.btn:contains("Cancel")').click()
      assert.calledOnce(spy)

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
      $buttons = $el.find('button.btn')
      assert.equals($buttons.length, 2)
      assert.match($buttons.text(), 'Cancel')
      assert.match($buttons.text(), 'Ok')

    'supports arguments passed in as hash': ->
      d = dialog
        title: 'Title'
        body: 'Body'
        buttons: [
          'Cancel', 'Ok'
        ]

      assert.match(d.el, innerHTML: 'Title')
      assert.match(d.el, innerHTML: 'Body')

      $buttons = d.$el.find('button.btn')
      assert.equals($buttons.length, 2)
      assert.match($buttons.text(), 'Cancel')
      assert.match($buttons.text(), 'Ok')

    'adds handlers to buttons': ->
      spy = @spy()
      dialog('Title', 'Body', [[ 'Ok', spy ]])
        .$el
        .find('button.btn')
        .click()
      assert.calledOnce(spy)

    'buttons can be DOM elements': ->
      $el = dialog('Title', 'Body', [
        $('<button class="btn">').html('Ok')[0]
      ]).$el
      $buttons = $el.find('button.btn')
      assert.equals($buttons.length, 1)
      assert.equals($buttons.text(), 'Ok')

    'buttons can be jQuery object': ->
      $el = dialog('Title', 'Body', [
        $('<button class="btn">').html('Ok')
      ]).$el
      $buttons = $el.find('button.btn')
      assert.equals($buttons.length, 1)
      assert.equals($buttons.text(), 'Ok')

    'adds body to modal element': ->
      assert.match(
        dialog('Foo Title', 'Bar Body').el
        innerHTML: 'Bar Body')

    'calls $.fn.modal on proper element': ->
      spy = @spy($.fn, 'modal')
      $el = dialog().$el
      assert.calledOn(spy, $el)

    'sets a static backdrop': ->
      spy = @spy($.fn, 'modal')
      dialog()
      assert.calledOnceWith(spy, backdrop: 'static')

    '.resolve closes modal': ->
      promise = dialog()
      spy = @spy($.fn, 'modal')
      promise.resolve()
      assert.calledOnceWith(spy, 'hide')

    '.reject closes modal': ->
      promise = dialog()
      spy = @spy($.fn, 'modal')
      promise.reject()
      assert.calledOnceWith(spy, 'hide')

    'removes the modal on close': ->
      promise = dialog()
      $el = $('<div>').html(promise.el)
      promise.resolve()
      assert.equals($el.html(), '')

    'has close button by default': ->
      spy = @spy()
      promise = dialog()
      promise.fail(spy)
      promise.$el.find('button.close').click()
      assert.calledOnce(spy)

    'pressing ESC .rejects the modal': ->
      spy = @spy()
      dialog().fail(spy)
      triggerKey(ESC)
      assert.calledOnce(spy)

    '.reject removes ESC key handler from body': ->
      promise = dialog().reject()
      spy = @spy(promise, 'reject')
      triggerKey(ESC)
      refute.called(spy)

    '.resolve removes ESC key handler from body': ->
      promise = dialog().resolve()
      spy = @spy(promise, 'reject')
      triggerKey(ESC)
      refute.called(spy)

  'prompt':

    'is a function': ->
      assert.isFunction(prompt)

    'calls .dialog with default title': ->
      prompt()
      assert.match(@dialogSpy.args[0][0], title: 'Please enter a value')

    'does not turn undefined body into "undefined" string': ->
      prompt()
      assert.match @dialogSpy.args[0][0],
        title: 'Please enter a value'
        body: ''

    'calls .dialog with title and body': ->
      prompt(title: 'Title', body: 'Body')
      assert.match(@dialogSpy.args[0][0], title: 'Title', body: 'Body')

    'returns same as .dialog': ->
      assert(@dialogSpy.returned(prompt()))

    'creates modal with "Cancel" and "Ok" buttons': ->
      $buttons = prompt().$el.find('button.btn')
      assert.equals($buttons.length, 2)
      assert.match($buttons.text(), 'Cancel')
      assert.match($buttons.text(), 'Ok')

    '"Ok" button has class btn-primary': ->
      $btn = prompt().$el.find('button.btn:contains("Ok")')
      assert.className($btn[0], 'btn-primary')

    'danger options gives "Ok" button btn-danger class': ->
      $btn = prompt(danger: true).$el.find('button.btn:contains("Ok")')
      assert.className($btn[0], 'btn-danger')

    'creates modal input field': ->
      $input = prompt().$el.find('input')
      assert.equals($input.length, 1)

    'clicking "Ok" button triggers .resolve with input value': ->
      promise = prompt()
      spy = @spy(promise, 'resolve')
      $el = promise.$el
      $el.find('input').val('Foobar')
      $el.find('button:contains("Ok")').click()
      assert.calledOnceWith(spy, 'Foobar')

    'clicking "Cancel" button triggers .reject': ->
      promise = prompt()
      spy = @spy(promise, 'reject')
      promise.$el.find('button:contains("Cancel")').click()
      assert.calledOnce(spy)

    'pressing Return in the input field submits': ->
      spy = @spy()
      prompt()
        .done(spy)
        .$el.find('input').val('foobar')
      triggerKey(RETURN)
      assert.calledOnceWith(spy, 'foobar')

    '.reject removes Return key handler from body': ->
      promise = prompt().reject()
      spy = @spy(promise, 'resolve')
      triggerKey(RETURN)
      refute.called(spy)

    '.resolve removes ESC key handler from body': ->
      promise = prompt().resolve()
      spy = @spy(promise, 'resolve')
      triggerKey(RETURN)
      refute.called(spy)

    'input has focus': ->
      spy = @spy($.fn, 'focus')
      assert.calledOn(spy, prompt().$input)
      assert.callOrder(@dialogSpy, spy)
