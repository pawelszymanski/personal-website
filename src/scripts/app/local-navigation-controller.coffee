class LocalNavigationController

  ANCHOR_SELECTOR: "a[href^='#']"
  NAVIGATION_ANCHOR_SELECTOR: "#navigation a[href^='#']"
  SECTION_SELECTOR: "section"

  ACTIVE_CLASS: 'active'

  ANIMATION_TIME: 600
  ANIMATION_TYPE: 'swing'

  THROTTLE: 50

  scrollToTop: =>
    $('html, body').animate {scrollTop: 0}, 500

  setActiveAnchor: (anchorName) =>
    $(@NAVIGATION_ANCHOR_SELECTOR).removeClass(@ACTIVE_CLASS)
    $("#navigation a[href='##{anchorName}']").addClass(@ACTIVE_CLASS)

  getAnchorOffsetTop: (anchorName) =>
    $("a[name='#{anchorName}']").offset().top

  getVisibleSectionName: =>
    sectionName = null
    $($(@SECTION_SELECTOR).get().reverse()).each (i, elem) =>
      if !sectionName and ($(window).scrollTop() >= $(elem).offset().top) then sectionName = $(elem).attr('id')
    return sectionName

  initAnchorClickEvent: =>
    $(@ANCHOR_SELECTOR).on 'click', (event) =>
      event.preventDefault()
      $el = $(event.currentTarget)
      anchorName = $el.attr('href').replace('#', '')
      @setActiveAnchor(anchorName)
      $('html, body')
        .stop()
        .animate(
          {scrollTop: @getAnchorOffsetTop(anchorName)},
          @ANIMATION_TIME,
          @ANIMATION_TYPE
      )

  initWindowScrollEvent: =>
    $(window).on 'scroll', () =>
      clearTimeout(@timeout)
      @timeout = setTimeout (() => @setActiveAnchor(@getVisibleSectionName())), @THROTTLE

  constructor: ->
    @timeout = null

    @scrollToTop()
    @initAnchorClickEvent()
    @initWindowScrollEvent()



$ ->
  window.app = window.app || {}
  window.app.LocalNavigationController = new LocalNavigationController
