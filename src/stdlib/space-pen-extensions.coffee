_ = require 'underscore'
{View} = require 'space-pen'
jQuery = require 'jquery'

originalRemove = View.prototype.remove

_.extend View.prototype,
  observeConfig: (keyPath, callback) ->
    @subscribe(config.observe(keyPath, callback))

  subscribe: (subscription) ->
    @subscriptions ?= []
    @subscriptions.push(subscription)

  unsubscribe: ->
    subscription.destroy() for subscription in @subscriptions ? []

  remove: (args...) ->
    @unsubscribe()
    originalRemove.apply(this, args)

originalCleanData = jQuery.cleanData
jQuery.cleanData = (elements) ->
  jQuery(element).view()?.unsubscribe?() for element in elements
  originalCleanData(elements)
