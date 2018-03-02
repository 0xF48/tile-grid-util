# Tile Grid Matrix

`npm i tile-grid-matrix`


> tile grids...tile grids everywhere!
😵🤪🤭🧐🤯

manage tile grids of any size with this handy library, resize, insert, sort, and crop your tiled grid.


```javascript

```

### things to keep in mind
- setHeight is more efficient than setWidth
- 




# TileGrid

## Props
`width` : the initial width of the grid.
`height` : the initial height of the grid.


### setWidth(width,dir)
update the `width` of the grid by either adding or removing rows from either top or bottom. when `dir` > 0, add or remove from bottom. otherwise add or remove from top, defaults to 1

### setHeight(width,dir)
update the `height` of the grid by either adding or removing rows from either left or right. when `dir` > 0, add or remove from right. otherwise add or remove from left, defaults to 1