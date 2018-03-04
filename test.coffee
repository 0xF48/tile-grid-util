{TileGrid,Tile,Rect} = require './tile-grid-matrix.coffee'
global.log = console.log.bind(console)

# som arbitrary array of items.
items = [0...5].map (i)->
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
		max_x: Math.round(Math.random()*3)
		max_y: Math.round(Math.random()*3)
		item: item

	bound = new Rect 
		min_x: g.full.max_x
		max_x: g.max_x
		min_y: g.full.max_y
		max_y: g.max_y

	console.log g.addItem(tile,bound)
	# break


# console.log g.item_list
pm()




# freeSpace = (item,x,y)->
# 	return g.freeSpace(x,y,item.w,item.h)


# for item in items
# 	min_x = null
# 	max_x = g.width
# 	min_y = g.height
# 	max_y = g.height
	
# 	g.addItemToMatrix(item,min_x,max_x,min_y,max_y,freeSpace)
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
