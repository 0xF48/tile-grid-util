# Tile Grid Utility Class

`npm i tile-grid-util`

*UNSTABLE*

> tile grids...tile grids everywhere! 🤯

This javascript utility library allows you to create tile grids, add/remove rows, resize the grid, and more.

`import {TileGrid,Grid,Rect} from "tile-grid-util"`


# TileGrid Class

## Constructor Object Props
`width` : the initial width of the grid.
`height` : the initial height of the grid.
```
my_grid = new TileGrid({
	width: 4,
	height: 6
})
```

## Methods

### .set(x1,x2,y1,y2) 
set the bounds of the grid. x1: left, x2: right, y1: top, y2: bottom  
```javascript
my_grid.set(my_grid.x1 - 1,my_grid.x2 + 1,my_grid.y1 - 1,my_grid.y2 + 1) //add one unit to each side of the grid
```

### .pad(x1,x2,y1,y2) 
same as set but will add the new values to the already existing bounds 
```javascript
my_grid.set(-1,1,-1,1) //add one unit to each side of the grid
```


### .full {x1,x2,y1,y2}
a `Rect` containing full first and last rows/columns of the grid.


### .add(tile,x1,x2,y1,y2,onFull) 
add a tile to first free spot within the specified bound `Rect`
```javascript
// x1,x2,y1,y2 are search bounds.
my_grid.add(my_tile,0,my_grid.full.x1,0,my_grid.full.y1); //search from top left to bottom right until the first full row/column.

my_grid.add(my_tile,0,my_grid.full.x1,0,my_grid.full.y1); //search from last full row and last full column to the bottom right

my_grid.add(my_tile,0,my_grid.full.x1,0,my_grid.full.y1,0); //search from first full row/column to top left
```




# Tile Class

## Constructor Object Props
`width` : the initial width of the tile.
`height` : the initial height of the tile.
```
my_grid = new Tile({
	width: 4,
	height: 6
})
```


# Tile


# Rect