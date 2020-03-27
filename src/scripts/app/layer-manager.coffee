class LayerManager

  BLUR = {property: 'filter', fn: (offset) -> "blur(#{Math.min(9, Math.abs(offset / 200))}px)"}
  OPACITY = {property: 'opacity', fn: (offset) -> "#{1 - Math.abs(offset / 1000)}"}

  LAYERS: [
    { selector: 'section h4', scrollSpeed: +0.25, cssCallbacks: [BLUR, OPACITY] }
    { selector: 'section h2', scrollSpeed: -0.45, cssCallbacks: [BLUR, OPACITY] }
    { selector: 'cite', scrollSpeed: +2, cssCallbacks: [BLUR, OPACITY] }
  ]

  initLayers: =>
    @LAYERS.forEach (layer) =>
      layer.elements = []
      $(layer.selector).each (index, element) =>
        layer.elements.push
          $el: $(element)
          initialTop: $(element).offset().top
          sectionInitialTop: $(element).offsetParent().first().offset().top
      layer.offsetBase = layer.elements[0].$el.offset().top

  adjustElements: =>
    scrollTop = $('html').scrollTop()
    @LAYERS.forEach (layer) =>
      layer.elements.forEach (element) =>
        offset = (scrollTop - element.sectionInitialTop)
        element.$el.offset({top: element.initialTop + (offset * layer.scrollSpeed)})
        if layer.cssCallbacks
          layer.cssCallbacks.forEach (cb) =>
            element.$el.css cb.property, cb.fn(offset)

  constructor: ->
    @initLayers()
    @adjustElements()

    @timer = null
    @throttle = 0

    $(window).on 'scroll', =>
      clearTimeout(@timer)
      @timer = setTimeout(@adjustElements, @throttle)



$ ->
  new LayerManager
