window.App or window.App = {}
App = window.App

class App.ActiveZoneCtrl extends Monocle.Controller

    events:
        'tap .js-add-to-fav-btn' : 'onAddToFav'
        'tap .js-view-trips-btn' : 'onViewTrips'

    elements:
        '#orig-station-select' : 'origStationSelect'
        '#dest-station-select' : 'destStationSelect'
        '#trip-date' : 'tripDate'

    constructor: ->
        super
        __Model.Zone.bind 'update', @bindZoneChange
        __Model.Zone.bind 'active', @refreshActive

    bindZoneChange: (zone) =>
        if zone.isActive()
            @refreshHeader zone

    onAddToFav: ->
        __Model.Zone.getActive().toggleFavourite()

    onViewTrips: =>
        orig = @origStationSelect.val()
        dest = @destStationSelect.val()
        date = @tripDate.val()
        @url 'trip/from', orig, 'to', dest

    refreshHeader: (zone) =>
        view = new __View.ActiveZoneHeader model: zone, container: '#zone-section header'
        view.html zone

    refreshActive: (zone) =>
        @refreshHeader zone
        stations = __Model.Station.inZone zone
        @fillSelectInput '#orig-station-select', stations
        @fillSelectInput '#dest-station-select', stations

    fillSelectInput: (container, stations) ->
        first = true
        for station in stations
            view = new __View.StationFormOption model: station, container: container
            method = if first then 'html' else 'append'
            view[method] station
            first = false
