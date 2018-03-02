TileGrid = require './tile-grid-matrix.coffee'

items = [0...100].map (i)->
	item_num: i


g = new TileGrid

for item in items
	width = Math.floor(1+Math.random()*2)
	height = Math.floor(1+Math.random()*2)
	g.addItem(item,width,height)


freeSpace = (item,x,y)->
	

for item in items
	x = null
	y = g.height
	g.addItemToMatrix(pos,x,y,freeSpace)


console.log '--width--'

console.log '4,1'
console.log g.setWidth(4,1)


console.log '5,-1'
console.log g.setWidth(5,-1)


console.log '5,-1'
console.log g.setWidth(5,-1)


console.log '4,1'
console.log g.setWidth(4,1)

console.log '2,-1'
console.log g.setWidth(2,-1)


console.log '6,1'
console.log g.setWidth(6,1)


console.log '7,-1'
console.log g.setWidth(6,1)




console.log '--height--'

console.log '4,1'
console.log g.setHeight(4,1)


console.log '5,-1'
console.log g.setHeight(5,-1)


console.log '5,-1'
console.log g.setHeight(5,-1)


console.log '4,1'
console.log g.setHeight(4,1)


console.log '2,-1'
console.log g.setHeight(2,-1)


console.log '6,1'
console.log g.setHeight(6,1)


console.log '7,-1'
console.log g.setHeight(6,1)
