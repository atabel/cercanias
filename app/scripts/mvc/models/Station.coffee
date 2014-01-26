class __Model.Station extends __Model.BaseModel
    @fields 'name',
            'id',
            'zoneId'

    @inZone: (zone)->
        if typeof zone is 'object' and zone.id?
            zoneId = zone.id
        else
            zoneId = zone
        @select (station) -> station.zoneId is zoneId
