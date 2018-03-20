{h,Component} = require 'preact'
{TileGrid,Tile,Rect} = require './tile-grid-util.coffee'


# class Test extends Component
# 	constructor: ->
		
		
# 	draw: ->
# 		log 'draw'

# 	freeSpace: ->


# 	buildGrid: ->
# 		@grid = new TileGrid
# 			width: 8
# 			height: 8
# 		@tiles = []
# 		for i in [0...30]
# 			tile = new Tile
# 				width: Math.floor(1+Math.random()*2)
# 				height: Math.floor(1+Math.random()*2)
# 			@grid.addTile(tile,@grid.full.x1,0,@grid.full.x1,0,@grid.full.y1)
	
# 	refCanvas: (el)=>
# 		@_canvas = el
# 		@_ctx = @_canvas.getContext('2d')
# 		@draw()


# 	render: ->
# 		h 'button',
# 			className: 'btn'
# 			'add row'
# 		h 'button',
# 			className: 'btn'
# 			'add column'


# 		h 'canvas',
# 			ref: @refCavas

render(h(Test),document.body,@docs_el)