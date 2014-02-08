window.App or window.App = {}
App = window.App

class App.ZoneListCtrl extends Monocle.Controller

    constructor: ->
        super
        __Model.Zone.bind 'create', @bindZoneCreate
        __Model.Zone.bind 'change', @bindZoneChange

        @updateAllZonesLst()

    bindZoneCreate: (zone) =>
        @

    bindZoneChange: (zone) =>
        @updateAllZonesLst()


    updateAllZonesLst: ->
        zones = __Model.Zone.all()
        @updateZonesLst zones, 'article#zones-article'

        zones = __Model.Zone.favourites()
        if zones.length
            @updateZonesLst zones, 'article#favourite-zones-article'
        else
            Lungo.Article.clean 'favourite-zones-article', 'star', 'No hay zonas favoritas', 'Añade zonas como favoritas para verlas aquí.'
        Lungo.Element.count '#favourite-zones-tab-btn', zones.length


    updateZonesLst: (zones, container, defaultView=null) ->
        Monocle.Dom(container).html '<ul><li class="anchor theme">Elige una zona</li></ul>'
        container = Monocle.Dom(container).find('ul')[0]
        for zone in zones
            view = new __View.Zoneli model: zone, container: container
            view.append zone
