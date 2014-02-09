
window.App = App = do () ->

    init = ->
        #Define the LungoJS Application Instance
        Lungo.init
            name : 'Cercanias'
            version : '0.1'
            resources: [
                '/sections/zone.html'
                '/sections/trip.html'
            ]
        #Hack to prevent premature hide of loading spiner
        oldHide = Lungo.Notification.hide
        Lungo.Notification.hide = (args...) ->
            setTimeout oldHide.bind(Lungo.Notification, args), 500

        Lungo.ready initApp

    initApp = ->
        Lungo.Notification.show()
        App.Services.getZones().then (zonesJson) ->
            for zoneAttrs in zonesJson
                __Model.Zone.updateOrCreate zoneAttrs

            stations = zonesJson.map (attrs) -> App.Services.getStationsInZone attrs.id
            return Promise.all stations
        .then (stationsJson) ->
            stationsJson = Array::concat.apply [], stationsJson
            for stationAttrs in stationsJson
                __Model.Station.updateOrCreate stationAttrs
            __Controller.ZoneLst = new App.ZoneListCtrl '#main-section'
            __Controller.ActiveZone = new App.ActiveZoneCtrl '#zone-section'
            __Controller.ActiveZoneMap = new App.ActiveZoneMapCtrl '#zone-section'
            __Controller.Trip = new App.TripCtrl '#trip-section'
        .finally ->
            Lungo.Notification.hide()

    {
        init : init
    }

App.init()
