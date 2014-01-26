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
        @updateZonesLst zones, 'article#zones-article ul'

        zones = __Model.Zone.favourites()
        @updateZonesLst zones, 'article#favourite-zones-article ul'
        Lungo.Element.count '#favourite-zones-tab-btn', zones.length


    updateZonesLst: (zones, container) ->
        first = true
        for uid, zone of zones
            view = new __View.Zoneli model: zone, container: container
            method = (if first then 'html' else 'append')
            view[method] zone
            first = false
