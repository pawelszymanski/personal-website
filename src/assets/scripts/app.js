var LayerManager, NavigationAnimation;

NavigationAnimation = (function() {
  class NavigationAnimation {
    constructor() {
      $(this.NAV_ITEMS_SELECTOR).on('click', (event) => {
        var targetAnchorName;
        event.preventDefault();
        targetAnchorName = $(event.currentTarget).attr('href').replace('#', '');
        return $('html, body').animate({
          scrollTop: $(`a[name='${targetAnchorName}']`).offset().top
        }, this.ANIMATION_TIME, 'swing');
      });
    }

  };

  NavigationAnimation.prototype.NAV_ITEMS_SELECTOR = '#navigation a';

  NavigationAnimation.prototype.ANIMATION_TIME = 600;

  return NavigationAnimation;

}).call(this);

$(function() {
  return new NavigationAnimation();
});

LayerManager = (function() {
  class LayerManager {
    initLayers() {
      return this.LAYERS.forEach((layer) => {
        layer.elements = [];
        $(layer.selector).each((index, element) => {
          return layer.elements.push({
            $el: $(element),
            initialOffset: $(element).offset().top
          });
        });
        return layer.offsetBase = layer.elements ? layer.elements[0].$el.offset().top : null;
      });
    }

    adjustElements() {
      var scrollTop;
      scrollTop = $('html').scrollTop();
      return this.LAYERS.forEach((layer) => {
        return layer.elements.forEach((element) => {
          var offsetTop, relativeOffset;
          relativeOffset = element.initialOffset - layer.offsetBase;
          offsetTop = element.initialOffset + ((relativeOffset - scrollTop) * layer.scrollSpeed);
          return element.$el.offset({
            top: offsetTop
          });
        });
      });
    }

    constructor() {
      this.initLayers = this.initLayers.bind(this);
      this.adjustElements = this.adjustElements.bind(this);
      this.initLayers();
      this.adjustElements();
      $(window).on('scroll', () => {
        return this.adjustElements();
      });
    }

  };

  LayerManager.prototype.LAYERS = [
    {
      selector: 'section h4',
      scrollSpeed: 0.5
    },
    {
      selector: 'section h2',
      scrollSpeed: 2.5
    }
  ];

  return LayerManager;

}).call(this);

$(function() {
  return new LayerManager();
});
