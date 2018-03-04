#javascript utility library to manage tile grids with arbitrary data.


DEFAULT_OPT = 
	max_x: 3
	max_y: 3

_clamp = (n,min,max)->
	return Math.min(Math.max(n, min), max)


# base rect class ith "bounds".
class Rect
	constructor: (opt)->
		if !opt
			@set()
		else
			@set(opt.min_x,opt.max_x,opt.min_y,opt.max_y)
	
	set: (min_x,max_x,min_y,max_y)->
		@min_x = min_x || -1
		@max_x = max_x || -1
		@min_y = min_y || -1
		@max_y = max_y || -1
		return @

	normalize: ->
		if @min_x < 0
			@max_x += @min_x
			@min_x = 0
		if @min_y < 0
			@max_y += @min_y
			@min_y = 0

	loopMatrix: (matrix,cb,argA,argB)->

		for y in [@min_y..@max_y]
			if y < 0 then continue
			if y > matrix.length then return false
			for x in [@min_x..@max_x]
				if matrix[y][x] == undefined then continue
				if cb(matrix[y][x],x,y,argA,argB) == false
					return false
		return true

	loopRect: (cb,argA,argB)->
		for y in [@min_y..@max_y]
			for x in [@min_x..@max_x]
				if cb(x,y,argA,argB) == false
					return false
		return true


# tile class, added as items in grid
class Tile extends Rect
	constructor: (opt)->
		super(opt)
		@item = opt.item
		@rect = opt.rect || null

	setXY: (x,y)->
		@rect.set(x,x+@max_x,y,y+@max_y)


# main grid class
class TileGrid extends Rect
	constructor: (opt)->
		super()
		
				@matrix = [] #2d matrix array that contains references to items in the list.
		@item_list = [] # a list of items.
		@removed = []
		@full = new Rect() # keep track of what portion of the matrix is full.
		@full.count_x = []
		@full.count_y = []
		@set(0,opt.width-1,0,opt.height-1)
		

	# clear one coordinate from matrix
	clearCoord: (item,x,y)=>
		@matrix[y][x] = null


	isItemNull: (item)=>
		item == null

	isCoordEmpty: (x,y)=>
		@matrix[y][x] == null

	# set the coordinate
	setCoord: (item,x,y,new_item)=>
		if item then throw new Error 'setCoord, coord taken ['+x+','+y+'] by '+item
		@matrix[y][x] = new_item
		@incrY(y)
		@incrX(x)

	decrY: (y)->
		@matrix[y].count--
		if @full.max_y > y
			@full.max_y = y

	# increment row full value
	incrY: (y)->
		@full.count_y[y]++
		if @full.count_y[y] == @width
			for yi in [@full.min_y..@max_y]
				if @full.count_y[yi] != @width
					@full.min_y = yi-1
					break
	
	incrX: (x)->
		@full.count_x[x]++
		if @full.count_x[x] == @width
			for xi in [@full.min_x..@max_x]
				if @full.count_x[xi] != @height
					@full.min_x = xi-1
					break




	# clear all items in a rect from the matrix
	clearRect: (rect)->
		rect.loopMatrix(@matrix,@clearItem)

	# set all coords in item rect to item.
	setItem: (item,x,y)->
		item.setXY(x,y)
		item.rect.loopMatrix(@matrix,@setCoord,item)

	# clear one item from the matrix
	clearItem: (item)=>
		if !item.rect
			throw new Error 'cant clear item, item has no rect.'
		item.rect.loopMatrix(@matrix,@clearCoord)
		item.rect = null
		log 'cleared item'
		@removed.push item

	# clear a row from matrix
	clearY: (y)->
		for item in @matrix[y]
			@clearItem(item)

	# clear a column from matrix
	clearX: (x)->
		for y in @matrix
			@clearItem y[x]

	# insert column(s) into matrix
	insertX: (pos,count)->
		pos = _clamp(0,@)
		for y in @matrix
			for i in [0...count]
				y.splice(pos,0,null)

	# insert row(s) into matrix
	insertY: (pos,count)->
		pos = _clamp(0,@max_y)
		if pos > 0
			for x in [0..@max_x]
				if @matrix[x][pos] == @matrix[x][pos-1]
					@freeSpot(x,pos)
		
		for i in [0...count]
			@matrix.splice(pos,0,new Array(@max_x).fill(null))

	# set new bounds for matrix.
	set: (min_x,max_x,min_y,max_y)->

		diff = new Rect
			min_x: min_x - @min_x
			max_x: max_x - @max_x
			min_y: min_y - @min_y
			max_y: max_y - @max_y 
		
		#diff X
		if diff.max_x > 0
			for i in [0..diff.max_x]
				for y in @matrix
					y.push null
		else if diff.max_x < 0
			for i in [0..diff.max_x]
				@clearX(@max_x+i)
				for y in @matrix
					y.pop()
		@max_x = max_x

		if diff.min_x > 0
			for i in [0..diff.min_x]
				for row in @matrix
					row.unshift null
		else if diff.min_x < 0
			for i in [0..diff.min_x]
				@clearX(0)
				for row in @matrix
					row.shift()
		@min_x = min_x
		
		# diff Y
		if diff.max_y > 0
			for i in [0..diff.max_y]
				@matrix.push new Array(@max_x+1).fill(null)
		else if diff.max_y < 0
			for i in [0..diff.max_y]
				@clearY(@matrix.length-1)
				@matrix.pop()
			# for i in [0...diff.max_y]
		@max_y = max_y

		if diff.min_y > 0
			for i in [0..diff.max_y]
				@clearY(0)
				@matrix.shift()
		else if diff.min_y < 0
			for i in [0..diff.max_y]
				@matrix.unshift new Array(@max_x+1).fill(null)
		@min_y = min_y

		@normalize()

		@width = @max_x+1
		@height = @max_y+1


	# check empty rect
	checkEmptyRect: (x,y,rect,empty_rect)=>
		empty_rect.set(x,x+rect.max_x,y,y+rect.max_y)

		#FIX
		# continue search.
		if @matrix[empty_rect.max_y][empty_rect.max_x] then return true

		# log 'loop',rect
		if empty_rect.loopMatrix(@matrix,@isItemNull) == true
			return false
		else
			empty_rect.set()


	# find a free rect within bounds, if no rect is found, return null
	# rect min_x and min_y must be normalized.
	findEmptyRect: (rect,bounds,cb)->
		rect.normalize()
		bounds.max_x -= rect.max_x
		bounds.max_y -= rect.max_y

		# log bounds,rect
		if bounds.max_x - bounds.min_x < 0
			log 'x out of bounds'
			return null
		if bounds.max_y - bounds.min_y < 0
			log 'y out of bounds'
			return null

		empty_rect = new Rect

		# log bounds

		
		bounds.loopRect(@checkEmptyRect,rect,empty_rect)

		# log bounds.min_x

		if empty_rect.max_x != -1 && empty_rect.max_y != -1
			return empty_rect
		else
			return null


	# add an item with a specific bound to look for free space, if no free space, the cb will be called and space will be searched again but without a callback. if no callback is provided will either place the item or return false.
	addItem: (item,bound,cb)->
		log 'addItem',item.item.n
		found_rect = @findEmptyRect(item,bound)
		if !found_rect
			return false
		else
			item.rect = found_rect
			item.rect.loopMatrix(@matrix,@setCoord,item)
			@item_list.push item
			return true





module.exports = {Rect,Tile,TileGrid}