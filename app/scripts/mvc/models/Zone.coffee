class __Model.Zone extends __Model.BaseModel
    @fields 'name',
            'id',
            'favourite'

    @favourites: ->
        @select (zone) -> !!zone.favourite

    @setActive: (zone) ->
        @_active = zone
        zone.trigger 'active'

    @getActive: () ->
        @_active

    active: () ->
        __Model.Zone.setActive @

    isActive: () -> @equal @constructor.getActive()

    toggleFavourite: () ->
        @updateAttributes favourite: !@favourite