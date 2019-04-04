# {h,Component} = require 'preact'
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

# render(h(Test),document.body,@docs_el)

grid = new TileGrid
	width: 2
	height: 8

g = new Tile
	width: 2
	height: 2
	item: 
		key: 'g'

grid.addTile g,grid.full.x2,grid.x2,grid.full.y2,grid.y2

for i in [0...5]
	tile = new Tile
		width: 1
		height: 1
		item: 
			key: i
	grid.addTile(tile,grid.full.x2,grid.x2,grid.full.y2,grid.y2)

grid.log()
grid.crop 0,2,0,3,(item,x,y)->
	console.log item,x,y



for i in [0...5]
	tile = new Tile
		width: 2
		height: 1+i
		item: 
			key: 'f'+i
	console.log grid.insertTile(tile,0,i)


grid.log()




	
# @grid.addTile(tile,@grid.full.x1,0,@grid.full.x1,0,@grid.full.y1)