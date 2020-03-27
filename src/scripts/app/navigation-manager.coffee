class NavigationAnimation

  NAV_ITEMS_SELECTOR: '#navigation a'
  ANIMATION_TIME: 600

  constructor: ->
    $(@NAV_ITEMS_SELECTOR).on 'click', (event) =>
      event.preventDefault()
      targetAnchorName = $(event.currentTarget).attr('href').replace('#', '')
      $('html, body')
        .stop()
        .animate({scrollTop: $("a[name='#{targetAnchorName}']").offset().top}, @ANIMATION_TIME, 'swing')



$ ->
  new NavigationAnimation
