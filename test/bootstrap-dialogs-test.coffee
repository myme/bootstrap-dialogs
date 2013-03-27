Bootstrap = this.Bootstrap
{alert, confirm, prompt} = Bootstrap.Dialog


buster = this.buster
assert = buster.assert
refute = buster.refute


buster.testCase 'Bootstrap.Dialog',

  'alert':

    'is a function': ->
      assert.isFunction(alert)

  'confirm':

    'is a function': ->
      assert.isFunction(confirm)

  'prompt':

    'is a function': ->
      assert.isFunction(prompt)
