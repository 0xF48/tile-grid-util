TileGrid = require './tile-grid-matrix.coffee'

g = new TileGrid


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
