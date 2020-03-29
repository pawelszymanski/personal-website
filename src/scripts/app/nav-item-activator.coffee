class NavItemActivator

  NAV_ITEM_SELECTOR: "#navigation a[href^='#']"

  ACTIVE_CLASS: 'active'

  firstAnchorName: =>
    $(@NAV_ITEM_SELECTOR).first().attr('href').replace('#', '')

  getActiveAnchorName: =>
    location.hash.replace('#', '') || @firstAnchorName()

  setActiveAnchor: (anchorName) =>
    $(@NAV_ITEM_SELECTOR).removeClass(@ACTIVE_CLASS)
    $("#navigation a[href='##{anchorName}']").addClass(@ACTIVE_CLASS)

  constructor: ->
    @setActiveAnchor(@getActiveAnchorName())



$ ->
  window.app = window.app || {}
  window.app.NavItemActivator = new NavItemActivator
