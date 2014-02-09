class __Model.Zone extends __Model.BaseModel
    @fields 'name',
            'id',
            'map',
            'favourite'

    @favourites: ->
        @select (zone) -> !!zone.favourite

    @setActive: (zone) ->
        oldActive = @getActive()
        @_active = zone
        zone.trigger 'active', oldActive

    @getActive: () ->
        @_active

    active: () ->
        __Model.Zone.setActive @

    isActive: () -> @equal @constructor.getActive()

    toggleFavourite: () ->
        @updateAttributes favourite: !@favourite