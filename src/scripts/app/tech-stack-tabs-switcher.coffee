class TechStackTabsSwitcher

  TAB_LINKS_SELECTOR: "#tech-stack ul.tab-list li"
  TAB_CONTENTS_SELECTOR: "#tech-stack .tab-content"

  ACTIVE_CLASS: 'active'

  setActiveTab: (index) =>
    $(@TAB_LINKS_SELECTOR).add(@TAB_CONTENTS_SELECTOR).removeClass(@ACTIVE_CLASS)
    $(@TAB_LINKS_SELECTOR).eq(index).addClass(@ACTIVE_CLASS)
    $(@TAB_CONTENTS_SELECTOR).eq(index).addClass(@ACTIVE_CLASS)

  initTabClickEvent: =>
    $(@TAB_LINKS_SELECTOR).on 'click', (event) =>
      @setActiveTab $(@TAB_LINKS_SELECTOR).index $(event.target)

  constructor: ->
    @setActiveTab(1)
    @initTabClickEvent()



$ ->
  window.app = window.app || {}
  window.app.TechStackTabsSwitcher = new TechStackTabsSwitcher
