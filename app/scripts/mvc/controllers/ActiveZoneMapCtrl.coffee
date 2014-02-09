window.App or window.App = {}
App = window.App

class App.ActiveZoneMapCtrl extends Monocle.Controller

    events:
        'load #zone-map-article' : 'onLoadMapArticle'

    onLoadMapArticle: =>
        activeZone = __Model.Zone.getActive()
        if not activeZone.equal @zone
            @refreshMap activeZone
            @zone = activeZone

    refreshMap: (zone) ->
        @mapCanvas = null
        view = new __View.MapCanvas model: {}, container: '#zone-map-article'
        view.html()
        canvas = Monocle.Dom('#map-canvas')[0]
        @mapCanvas = new ImgTouchCanvas canvas: canvas, path: "/images/map/#{zone.id}.png"
