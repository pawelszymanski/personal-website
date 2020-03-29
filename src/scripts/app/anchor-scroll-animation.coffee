class LocalAnchorOnClickAnimation

  ANCHOR_SELECTOR: "a[href^='#']"

  ANIMATION_TIME: 600
  ANIMATION_TYPE: 'swing'

  getAnchorOffsetTop: (anchorName) =>
    $("a[name='#{anchorName}']").offset().top

  replaceHistoryState: (title, anchorName) =>
    history.replaceState(null, title, '#' + anchorName)

  animateCallback: (anchorText, anchorName) =>
    @replaceHistoryState(anchorText, anchorName)
    app.NavItemActivator.setActiveAnchor(anchorName)

  constructor: ->
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



$ ->
  window.app = window.app || {}
  window.app.LocalAnchorOnClickAnimation = new LocalAnchorOnClickAnimation
