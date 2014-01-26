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
        .finally ->
            Lungo.Notification.hide()

    renderTrips: (trips) ->
        console.error trips
        model = trips : trips
        view = new __View.TripTable model: model, container: '#trip-section table'
        view.html model