{TileGrid,Tile,Rect} = require './tile-grid-matrix.coffee'
global.log = console.log.bind(console)

# som arbitrary array of items.
items = [0...4].map (i)->
	n: i

pm = ->
	console.log '-----------------\n\n'
	for y in g.matrix
		str = y.map (x)->
			return x && String(x.item.n) || '-'
		console.log(str.join(',     ')+'\n\n')

	console.log '-----------------'


		

g = new TileGrid
	width: 4
	height: 4

freeSpace = (item)->
	return g.addRow(g.height.item.height)

# create grid tiles and create a new bound to decide where that item can go.
for item in items

	tile = new Tile
		width: Math.round(1+Math.random()*2)
		height: Math.round(1+Math.random()*2)
		item: item

	bound = new Rect 
		x1: g.full.x2
		x2: g.x2
		y1: g.full.y2
		y2: g.y2

	g.addItem(tile,bound)


# console.log g.item_list
pm()




# freeSpace = (item,x,y)->
# 	return g.freeSpace(x,y,item.w,item.h)


# for item in items
# 	x1 = null
# 	x2 = g.width
# 	y1 = g.height
# 	y2 = g.height
	
# 	g.addItemToMatrix(item,x1,x2,y1,y2,freeSpace)
# 	break


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
