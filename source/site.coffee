{h,render,Component} = require 'preact'
{Box,Shader} = require 'shader-box'
Markdown = require 'preact-markdown'
require './site.less'
require 'normalize.css'
EXAMPLES = []
PROPS = []




class Header extends Component
	constructor: ->
		super()
		@state =
			title_snippet_pos_a: 0
			title_snippet_pos_b: 1
			show_bg: true
	
	componentDidMount: ->
		@t = Math.random()*10000
		@box = new Box
			canvas: @_canvas
			resize: true #auto resize on window.resize
			clearColor: [0.0, 0.0, 0.0, 1.0]
			context:
				antialias: false
				depth: false
		@gradient = new Shader
			code: require('./gradient.glsl')
			uniforms:
				pos:
					type:'2fv'
					val: [0.5,0.5]
				seed:
					type:'3fv'
					val: [1.1,1.3,1.2]
				speed:
					type:'1f'
					val:1.0
				fade:
					type:'1f'
					val:1.0
				iTime:
					type:'1f'
					val: @t

		@box.add(@gradient)
		@box.clear().draw(@gradient)
		@tick(@t)
		# setInterval @switchTitleSnippetTextA,1000
		setInterval @switchTitleSnippetTextB,2000

	
	switchTitleSnippetTextA: =>
		@setState
			title_snippet_pos_a: 1-@state.title_snippet_pos_a
	

	switchTitleSnippetTextB: =>
		@setState
			title_snippet_pos_b: 1-@state.title_snippet_pos_b
		
	
	tick: ()=>
		requestAnimationFrame(@tick)
		if window.scrollY > window.innerHeight && @state.show_bg
			@setState
				show_bg: false
		else if window.scrollY < window.innerHeight && !@state.show_bg
			@setState
				show_bg: true
		if !@state.show_bg
			return
		@gradient.uniforms.iTime.val = @t+=10
		@box.clear().draw(@gradient)
		


	render: ->
		h 'div',
			className: 'header'
			h 'canvas',
				style:
					visibility: !@state.show_bg && 'hidden' || null
				className: 'canvas'
				ref: (el)=>
					@_canvas = el
			h 'a',
				className: 'gradient-link center'
				href: 'https://github.com/arxii/shader-box-gradient'
				'?'

			h 'div',
				className: 'header-description',
				h 'div',
					className: 'title center'
					h 'a',
						href: "https://github.com/arxii/preact-slide"
						className: 'title-name'
						'Grid Utility Library'
					h 'a',
						href: "https://github.com/arxii/preact-slide"
						className: 'center github-link'
						h 'img',
							src: './site/github.svg'
				h 'p',
					className:'header-description-sub'
					'About'
				h 'p',
					className:'header-description-text'
					h Markdown,
						markupOpts:
							className: 'section-text'
						markdown: ABOUT
					h 'div',
						className: 'shields'
						h 'a',
							href:'https://npmjs.com/package/preact-slide'
							h 'img',
								src: 'https://img.shields.io/npm/v/preact-slide.svg?style=for-the-badge'
						h 'a',
							href:'https://travis-ci.org/arxii/preact-slide'
							h 'img',
								src: 'https://img.shields.io/travis/arxii/preact-slide.svg?style=for-the-badge'


ABOUT = require './ABOUT.md'

class Docs 
	render: ->
		h 'div',
			className: 'docs'
			h Header
			h 'div',
				className: 'section'
				h 'h1',{},'Props'
				PROPS.map (prop)->
					h 'div',
						className: 'prop'
						h 'div',
							className: 'prop-name'
							prop[0]
						h 'div',
							className: 'prop-default'
							prop[1]
						h Markdown,
							markdown: prop[2]
							markupOpts:
								className: 'prop-text'
		

			h 'div',
				className: 'examples section'
				h 'h1',
					margin: 10
					'Examples'
				EXAMPLES.map (example)->
					h 'div',
						className: 'example-section'
						h 'a',
							href: example[3]
							target: '_blank'
							className: 'section-title'
							h 'span',
								className: 'section-title-name'
								example[0]
						h Markdown,
							markdown: example[1]
							markupOpts:
								className: 'section-text'
						h example[2]
						example[3] && h 'a',
							href: example[3]
							className: 'section-title-link'
							target: '_blank'
							'</>'
			h 'footer',
				className: 'footer'
				h 'a',
					href: "https://github.com/arxii/preact-slide"
					className: 'footer-text'
					'Source'
				h 'a',
					href: "https://github.com/arxii/preact-slide/blob/master/LICENSE"
					className: 'footer-text'
					'Apache License 2.0'




@docs_el = null
render(h(Docs),document.body,@docs_el)
# hljs.initHighlightingOnLoad()



