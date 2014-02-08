class __View.SelectTripForm extends __View.BaseView
	template_url: 'templates/select_trip_form.mustache'

	elements:
        '#orig-station-select' : 'origStationSelect'
        '#dest-station-select' : 'destStationSelect'
        '#trip-date' : 'tripDate'

    events:
        'tap .js-view-trips-btn' : 'onViewTrips'

    onViewTrips: =>
        orig = @origStationSelect.val()
        dest = @destStationSelect.val()
        date = moment(@tripDate.val()).format 'YYYYMMDD'
        if @validateForm orig, dest, date
            @url 'trip/from', orig, 'to', dest, date

    validateForm: (orig, dest, date) ->
        (orig isnt 'default') and
        (dest isnt 'default') and
        (orig isnt dest)
