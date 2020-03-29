class Parallax

  BLUR = {property: 'filter', fn: (offset) -> "blur(#{Math.min(9, Math.abs(offset / 200))}px)"}
  OPACITY = {property: 'opacity', fn: (offset) -> "#{1 - Math.abs(offset / 1000)}"}

  LAYERS: [
    { selector: 'section h4', speed: +0.25, cssCallbacks: [BLUR, OPACITY] }
    { selector: 'section h2', speed: -0.45, cssCallbacks: [BLUR, OPACITY] }
    { selector: 'cite', speed: +2.00, cssCallbacks: [BLUR, OPACITY] }
  ]

  initElements: =>
    @LAYERS.forEach (layer) =>
      layer.elements = []
      $(layer.selector).each (index, element) =>
        layer.elements.push
          $el: $(element)
          initialTop: $(element).offset().top
          sectionInitialTop: $(element).offsetParent().first().offset().top
      layer.offsetBase = layer.elements[0].$el.offset().top

  repositionElements: =>
    scrollTop = $('html').scrollTop()
    @LAYERS.forEach (layer) =>
      layer.elements.forEach (element) =>
        offset = (scrollTop - element.sectionInitialTop)
        element.$el.offset({top: element.initialTop + (offset * layer.speed)})
        if layer.cssCallbacks
          layer.cssCallbacks.forEach (cb) =>
            element.$el.css cb.property, cb.fn(offset)

  constructor: ->
    @initElements()
    @repositionElements()

    @timer = null
    @throttle = 0

    $(window).on 'scroll', =>
      clearTimeout(@timer)
      @timer = setTimeout(@repositionElements, @throttle)



$ ->
  window.app = window.app || {}
  window.app.Parallax = new Parallax
