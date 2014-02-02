window.App or window.App = {}
App = window.App

class App.TripCtrl extends Monocle.Controller

    constructor: ->
        super
        @routes
            "trip/from/:orig/to/:dest" : @onViewTrip
        Monocle.Route.listen()

    onViewTrip: (params) =>
        getTrip = App.Services.getTripInZone __Model.Zone.getActive().id
        Lungo.Notification.show()
        getTrip(params.orig, params.dest).then (trips) =>
            Lungo.Router.section 'trip-section'
            @renderTrips trips
            @renderHeader __Model.Station.findBy('id', params.orig), __Model.Station.findBy('id', params.dest)
        .finally ->
            Lungo.Notification.hide()

    renderTrips: (trips) ->
        model = trips : trips
        view = new __View.TripTable model: model, container: '#trip-article'
        view.html model

    renderHeader: (origStation, destStation) ->
        model =
            from : origStation.name
            to : destStation.name
        view = new __View.TripHeader model: model, container: '#trip-section header'
        view.html model