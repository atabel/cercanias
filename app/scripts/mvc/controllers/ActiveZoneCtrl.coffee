window.App or window.App = {}
App = window.App

class App.ActiveZoneCtrl extends Monocle.Controller

    events:
        'tap .js-add-to-fav-btn' : 'onAddToFav'

    constructor: ->
        super
        __Model.Zone.bind 'active', @onZoneActivates
        __Model.Zone.bind 'change', @onZoneChange

    onZoneActivates: (zone, oldZone) =>
        Lungo.Router.article 'zone-section', 'zone-article'
        if not zone.equal oldZone
            @refreshActive zone

    onZoneChange: (zone) =>
        if zone.isActive()
            @refreshHeader zone

    onAddToFav: ->
        __Model.Zone.getActive().toggleFavourite()

    refreshActive: (zone) ->
        @refreshHeader zone
        stations = __Model.Station.inZone zone
        @refreshForm stations

    refreshHeader: (zone) ->
        view = new __View.ActiveZoneHeader model: zone, container: '#zone-section header'
        view.html zone

    refreshForm: (stations) ->
        model =
            stations : stations
            today : moment().format 'YYYY-MM-DD'
        view = new __View.SelectTripForm model: model, container: '#zone-article'
        view.html model
