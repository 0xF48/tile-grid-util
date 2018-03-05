{TileGrid,Tile,Rect} = require './tile-grid-util.coffee'
global.log = console.log.bind(console)

# Timer = ()->
# 	@t = 0
# 	start: ()=>
# 		@ts = Date.now()
# 	stop: ()=>
# 		@t = Date.now()-@ts
# 		console.log 'timer stopped - ',@t
# 	t: ()=>
# 		@t

# timer = Timer()

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
[0...30].map (i)->
	tile = new Tile
		width: Math.floor(1+Math.random()*2)
		height: Math.floor(1+Math.random()*2)
		item: 
			n:i

	bound = new Rect 
		x1: g.full.x2
		x2: g.x2
		y1: g.full.y2
		y2: g.y2


	g.addItem(tile,bound)
log g.full
g.log()

g.pad(-1,0,0,0)

log g.full
g.log()

g.pad(-1,0,0,0)


log g.full
g.log()

# [0...30].map (i)->
# 	tile = new Tile
# 		width: Math.floor(1+Math.random()*2)
# 		height: Math.floor(1+Math.random()*2)
# 		item:
# 			n: i+'b'

# 	bound = new Rect 
# 		x1: g.full.x2
# 		x2: g.x2
# 		y1: g.full.y1
# 		y2: 0

# 	g.addItem(tile,bound)




# g.log()
# g.pad(0,-1,0,0)

# for i in [0...100]
# 	g.pad(-Math.floor(Math.random()*3),0,-Math.floor(Math.random()*3),0)

# timer.stop()

# console.log g.item_list
# g.log()
# g.pad(0,0,0,0)
# g.log()





# console.log '--width--'

# console.log '4,1'
# console.log g.setWidth(4,1)


# console.log '5,-1'
# console.log g.setWidth(5,-1)


# console.log '5,-1'
# console.log g.setWidth(5,-1)


# console.log '4,1'
# console.log g.setWidth(4,1)

# console.log '2,-1'
# console.log g.setWidth(2,-1)


# console.log '6,1'
# console.log g.setWidth(6,1)


# console.log '7,-1'
# console.log g.setWidth(6,1)




# console.log '--height--'

# console.log '4,1'
# console.log g.setHeight(4,1)


# console.log '5,-1'
# console.log g.setHeight(5,-1)


# console.log '5,-1'
# console.log g.setHeight(5,-1)


# console.log '4,1'
# console.log g.setHeight(4,1)


# console.log '2,-1'
# console.log g.setHeight(2,-1)


# console.log '6,1'
# console.log g.setHeight(6,1)


# console.log '7,-1'
# console.log g.setHeight(6,1)
