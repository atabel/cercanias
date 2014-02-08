App = window.App or {}
App.Services = do () ->
    DOMAIN = 'http://renfeapi.herokuapp.com'
    URL =
        ZONES : DOMAIN + '/zones'
        ZONE : DOMAIN + '/zone/'

    Lungo.Data.Storage =
        persistent: Device.Storage.local,
        session: Device.Storage.session

    buildUrlForStationsInZone = (zoneId) ->
        URL.ZONE + zoneId + '/stations'

    buildUrlForTripInZone = (zoneId) ->
        URL.ZONE + zoneId + '/trip'

    buildTripQuery = (origStation, destStation) ->
        "/from/#{origStation}/to/#{destStation}"

    get = (url, data = {}) ->
        new Promise((resolve, reject) ->
            $$.ajaxSettings.error = reject
            Lungo.Service.cache url, data, '1 day', resolve
        )

    getZones = -> get URL.ZONES

    getStationsInZone = (zoneId) ->
        get(buildUrlForStationsInZone zoneId).then (stations) ->
            for station in stations
                station.zoneId = zoneId
            stations


    getTrip = (zoneId, origStation, destStation) ->
        getTripInZone(zoneId)(origStation, destStation, date)

    getTripInZone = (zoneId) ->
        zoneUrl = buildUrlForTripInZone zoneId
        (origStation, destStation, date) ->
            get zoneUrl + buildTripQuery(origStation, destStation), date: date

    {
        getZones : getZones
        getStationsInZone : getStationsInZone
        getTrip : getTrip
        getTripInZone : getTripInZone
    }
