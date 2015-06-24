if Package.templating?
	Template = Package.templating.Template
	Blaze = Package.blaze.Blaze
	HTML = Package.htmljs.HTML

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

	Blaze.registerHelper 'nrrargs', ->
		obj = {}
		obj._arguments = arguments
		return obj

	Blaze.renderNonReactive = (templateName, data) ->
		_arguments = this.parentView.dataVar.get()._arguments

		templateName = _arguments[0]
		data = _arguments[1]

		view = undefined
		Tracker.nonreactive ->
			view = new Blaze.View 'nrr', ->
				return HTML.Raw Blaze.toHTMLWithDataNonReactive Template[templateName], data

			view.onViewReady ->
				Template[templateName].onViewReady?.call view

		return view

	Blaze.registerHelper 'nrr', Blaze.Template('nrr', Blaze.renderNonReactive)