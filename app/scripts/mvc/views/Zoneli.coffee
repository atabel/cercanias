class __View.Zoneli extends __View.BaseView

	events:
		'tap li.zone-li': 'onTapZone'

	container: 'article#zones-article ul'

	template_url: 'templates/zone_li.mustache'

	onTapZone: (evt) =>
		@model.active()