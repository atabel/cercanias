window.App or window.App = {}
App = window.App

class App.PersistZoneCtrl extends Monocle.Controller

    constructor: ->
        super
        __Model.Zone.bind 'favourite', @onZoneFavourited

    onZoneFavourited: (zone) =>
        key = "zone:#{zone.id}"
        savedZone = JSON.parse(localStorage.getItem(key)) or {}
        savedZone.favourite = zone.favourite
        localStorage.setItem key, JSON.stringify(savedZone)
