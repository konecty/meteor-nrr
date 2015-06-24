if Package.templating?
	Template = Package.templating.Template
	Blaze = Package.blaze.Blaze

	Blaze.toHTMLWithDataNonReactive = (content, data) ->
		makeCursorReactive = (obj) ->
			if obj instanceof Meteor.Collection.Cursor
				obj._depend
					added: true
					removed: true
					changed: true

		makeCursorReactive data

		if data instanceof Spacebars.kw and Object.keys(data.hash).length > 0
			for key, value of data.hash
				makeCursorReactive value

			data = data.hash

		html = ''

		Tracker.nonreactive ->
			html = Blaze.toHTMLWithData content, data

		return html

	Blaze.renderNonReactive = (templateName, data) ->
		return Blaze.toHTMLWithDataNonReactive Template[templateName], data

	Blaze.registerHelper 'nonReactiveRender', Blaze.renderNonReactive

	Blaze.registerHelper 'nrr', Blaze.renderNonReactive