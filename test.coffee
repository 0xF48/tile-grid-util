{TileGrid,Tile,Rect} = require './tile-grid-util.coffee'
global.log = console.log.bind(console)


onFull= ()->
	# console.log 'full'
	return false


# som arbitrary array of items.
items = [0...30].map (i)->
	n: i


g = new TileGrid
	width: 5
	height: 5


freeSpace = (item)->
	return g.addRow(g.height.item.height)


# timer.start()
# create grid tiles and create a new bound to decide where that item can go.
# [0...30].map (i)->
# 	tile = new Tile
# 		width: Math.floor(1+Math.random()*2)
# 		height: Math.floor(1+Math.random()*2)
# 		item: 
# 			n:i

# 	g.add(tile,g.full.x2-1,g.x2,g.full.y2,g.y2,onFull)

# log g.full
# g.log()

# g.pad(0,0,-6,0)

[0...10].map (i)->
	tile = new Tile
		width: Math.floor(1+Math.random()*2)
		height: Math.floor(1+Math.random()*2)
		item: 
			n:i+'b'
	g.add(tile,g.x2-1,-1,g.full.y1,-1,onFull)
	

g.log()
log g.full
# g.insertX(3,1)
# g.insertY(3,1)
# g.log()
# log g.full

