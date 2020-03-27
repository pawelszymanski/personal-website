class LayerManager

  LAYERS: [
    { selector: 'section h4', scrollSpeed: 0.5 }
    { selector: 'section h2', scrollSpeed: 1.5 }
  ]

  initLayers: =>
    @LAYERS.forEach (layer) =>
      layer.elements = []
      $(layer.selector).each (index, element) =>
        layer.elements.push
          $el: $(element)
          initialOffset: $(element).offset().top
      layer.offsetBase = if layer.elements then layer.elements[0].$el.offset().top else null

  adjustElements: =>
    scrollTop = $('html').scrollTop()
    @LAYERS.forEach (layer) =>
      layer.elements.forEach (element) =>
        relativeOffset = element.initialOffset - layer.offsetBase
        offsetTop = element.initialOffset + ((relativeOffset - scrollTop) * layer.scrollSpeed)
        element.$el.offset({top: offsetTop})

  constructor: ->
    @initLayers()
    @adjustElements()

    $(window).on 'scroll', =>
      @adjustElements()



$ ->
  new LayerManager
