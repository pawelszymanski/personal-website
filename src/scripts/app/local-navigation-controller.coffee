class LocalNavigationController

  ANCHOR_SELECTOR: "a[href^='#']"
  NAVIGATION_ANCHOR_SELECTOR: "#navigation a[href^='#']"

  ACTIVE_CLASS: 'active'

  ANIMATION_TIME: 600
  ANIMATION_TYPE: 'swing'

  scrollToTop: =>
    $('html, body').animate {scrollTop: 0}, 500

  getFirstNavigationAnchorName: =>
    $(@NAVIGATION_ANCHOR_SELECTOR).first().attr('href').replace('#', '')

  setActiveAnchor: (anchorName) =>
    $(@NAVIGATION_ANCHOR_SELECTOR).removeClass(@ACTIVE_CLASS)
    $("#navigation a[href='##{anchorName}']").addClass(@ACTIVE_CLASS)

  clearLocationHash: =>
    history.pushState('', '', '/');

  getAnchorOffsetTop: (anchorName) =>
    $("a[name='#{anchorName}']").offset().top

  replaceHistoryState: (title, anchorName) =>
    history.replaceState(null, title, '#' + anchorName)

  animateCallback: (anchorText, anchorName) =>
    @replaceHistoryState(anchorText, anchorName)
    @setActiveAnchor(anchorName)

  initAnchorClickEvent: =>
    $(@ANCHOR_SELECTOR).on 'click', (event) =>
      event.preventDefault()
      $el = $(event.currentTarget)
      anchorName = $el.attr('href').replace('#', '')
      anchorText = $el.text()
      $('html, body')
        .stop()
        .animate(
          {scrollTop: @getAnchorOffsetTop(anchorName)},
          @ANIMATION_TIME,
          @ANIMATION_TYPE,
          () => @animateCallback(anchorText, anchorName)
      )

  constructor: ->
    @clearLocationHash()
    @setActiveAnchor(@getFirstNavigationAnchorName())
    @scrollToTop()
    @initAnchorClickEvent()



$ ->
  window.app = window.app || {}
  window.app.LocalNavigationController = new LocalNavigationController
