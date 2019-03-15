# Tile Grid Util (Unstable)

`npm i tile-grid-util`

This javascript utility library allows you to create tile grids, add/remove rows, resize the grid, and more.
> tile grids...tile grids everywhere! 🤯

`import {TileGrid,Grid,Rect} from "tile-grid-util"`


# Rect
Internal base rectangle class, contains x1,x2,y1,y2 properties for setting up search bounds and grid/tile sizes. both grid and tile classes extend this class.
```javascript
rect = new Rect(x1,x2,y1,y2) //set the vertices of the rectangle
```



# Tile{Rect}
```javascript
var tile = new Tile({
	width: 4, //tile size in grid units
	height: 6 //tile size in grid units
	item: reference to the object of your app that you want to associate with
})
```


# TileGrid{Rect}
```javascript
var grid = new TileGrid({
	width: 4, //width in grid units
	height: 6 //height in grid units
})
```


### Grid.full{Rect}
a `Rect` class containing full first and last rows/columns of the grid.



### Grid.crop(x1,x2,y1,y2,callback)
crop and return all itetms in specific bounds x1: left, x2: right, y1: top, y2: bottom  
```javascript
grid.crop(0,grid.x2,0,grid.y2,callback) // callback(item,x,y)
```


### Grid.set(x1,x2,y1,y2)
set the bounds of the grid. x1: left, x2: right, y1: top, y2: bottom  
```javascript
grid.set(grid.x1 - 1,grid.x2 + 1,grid.y1 - 1,grid.y2 + 1) //add one unit to each side of the grid
```


### Grid.pad(x1,x2,y1,y2)
same as set but will add the new values to the already existing bounds 
```javascript
grid.set(1,1,1,1) //add one unit to each side of the grid (left,right,top,bottom)
```


### Grid.addTile(tile,x1,x2,y1,y2) 
add a tile to first free spot within the specified bound `Rect`. returns false if no free spot has been found.

```javascript
	// prepend items
	function update_prepend_search_bounds(){
		bound_start_x = grid.full.x1
		bound_end_x = 0
		bound_start_y = grid.full.y1
		bound_end_y = 0
	}


	// append items
	function update_append_search_bounds(){
		bound_start_x = grid.full.x2
		bound_end_x = grid.x2
		bound_start_y = grid.full.y2
		bound_end_y = grid.y2
	}


	//append an item
	while(!grid.addTile(tile,bound_start_x,bound_end_x,bound_start_y,bound_end_y)){ //try to add an item
		grid.pad(0,0,0,10) //pad the grid a bit until you can
		set_append_search_bounds() // update the search bounds so you dont loop over the same search bounds forever
	}


	//prepend an item
	while(!grid.addTile(tile,bound_start_x,bound_end_x,bound_start_y,bound_end_y)){ //try to add an item
		grid.pad(0,0,10,0) //pad the grid a bit until you can
		update_prepend_search_bounds() // update the search bounds so you dont loop over the same search bounds forever
	}

```



`npm run build` compile coffeescript file