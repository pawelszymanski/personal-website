class AddActiveClassOnClickDirective

  SELECTOR: '[add-active-class-on-click]'

  CLASS_NAME: 'active'

  initClickEvent: =>
    $(@SELECTOR).on 'click', (event) =>
      $(event.target).addClass @CLASS_NAME

  constructor: ->
    @initClickEvent()



$ ->
  window.app = window.app || {}
  window.app.AddActiveClassOnClickDirective = new AddActiveClassOnClickDirective
