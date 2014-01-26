App = window.App or {}
App.Services = do () ->
    DOMAIN = 'http://renfeapi.herokuapp.com'
    URL =
        ZONES : DOMAIN + '/zones'
        ZONE : DOMAIN + '/zone/'

    buildUrlForStationsInZone = (zoneId) ->
        URL.ZONE + zoneId + '/stations'

    buildUrlForTripInZone = (zoneId) ->
        URL.ZONE + zoneId + '/trip'

    buildTripQuery = (origStation, destStation) ->
        "/from/#{origStation}/to/#{destStation}"

    get = (url, data = {}) ->
        new Promise((resolve, reject) ->
            Lungo.Service.get url, data, resolve
        )

    getZones = -> get URL.ZONES

    getStationsInZone = (zoneId) ->
        get(buildUrlForStationsInZone zoneId).then (stations) ->
            for station in stations
                station.zoneId = zoneId
            stations


    getTrip = (zoneId, origStation, destStation) ->
        getTripInZone(zoneId)(origStation, destStation)

    getTripInZone = (zoneId) ->
        zoneUrl = buildUrlForTripInZone zoneId
        (origStation, destStation) ->
            get zoneUrl + buildTripQuery(origStation, destStation)

    {
        getZones : getZones
        getStationsInZone : getStationsInZone
        getTrip : getTrip
        getTripInZone : getTripInZone
    }
