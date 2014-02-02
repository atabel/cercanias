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
        @url 'trip/from', orig, 'to', dest, date
