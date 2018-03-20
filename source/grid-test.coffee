{h,Component} = require 'preact'
{Slide} = require 'preact-slide'
{Toggle} = require 'preact-slide-toggle'
{Input} = require 'preact-slide-input'
{Input} = require 'preact-slide-button'



class GridExample extends Component
		
	draw: ->
		@_ctx


	componentDidMount: ->

	render: ->
		h 'div',
			className: ''
		h 'canvas',
			ref: 