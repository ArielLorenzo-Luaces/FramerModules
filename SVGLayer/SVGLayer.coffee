"""
SVGLayer class

properties
- linecap <string> ("round" || "square" || "butt")
- fill <string> (css color)
- stroke <string> (css color)
- strokeWidth <number>
"""

class exports.SVGLayer extends Layer

	constructor: (options = {}) ->
		options = _.defaults options,
			strokeWidth: 2
			stroke: "#28affa"
			backgroundColor: null
			clip: false
			fill: "transparent"
			linecap: "round"
		super options

		if options.fill == null
			@fill = null

		@width += options.strokeWidth / 2
		@height += options.strokeWidth / 2

		@path = options.path

	@define "path",
		get: -> @_path
		set: (value) ->
			# HTML for the SVG DOM element, need unique class names
			header = "<svg x='0px' y='0px' width='#{@width}' height='#{@height}' viewBox='-#{@strokeWidth/2} -#{@strokeWidth/2} #{@width + @strokeWidth/2} #{@height + @strokeWidth/2}'>"
			footer = "</svg>"
			@_path = value
			@html = header + @_path + footer

	@define "linecap",
		get: -> @style.strokeLinecap
		set: (value) ->
			@style.strokeLinecap = value

	@define "strokeLinecap",
		get: -> @style.strokeLinecap
		set: (value) ->
			@style.strokeLinecap = value

	@define "fill",
		get: -> @style.fill
		set: (value) ->
			if value == null
				value = "transparent"
			@style.fill = value

	@define "stroke",
		get: -> @style.stroke
		set: (value) -> @style.stroke = value

	@define "strokeColor",
		get: -> @style.stroke
		set: (value) -> @style.stroke = value

	@define "strokeWidth",
		get: -> Number(@style.strokeWidth.replace(/[^\d.-]/g, ''))
		set: (value) ->
			@style.strokeWidth = value
