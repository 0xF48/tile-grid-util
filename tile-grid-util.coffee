#javascript utility library to manage tile grids with arbitrary data.


DEFAULT_OPT = 
	x2: 3
	y2: 3

_clamp = (n,min,max)->
	return Math.min(Math.max(n, min), max)


# base rect class ith "bounds".
class Rect
	constructor: (opt)->
		if !opt
			@set()
		else
			@set(opt.x1,opt.x2,opt.y1,opt.y2)
	
	set: (x1,x2,y1,y2)->
		@x1 = x1 || 0
		@x2 = x2 || 0
		@y1 = y1 || 0
		@y2 = y2 || 0
		return @

	normalize: ->
		if @x1 < 0
			@x2 -= @x1
			@x1 = 0
		if @y1 < 0
			@y2 -= @y1
			@y1 = 0

	loopMatrix: (matrix,cb,argA,argB,argC)->

		for y in [@y1...@y2]
			if y < 0 then continue
			if y > matrix.length then return false
			for x in [@x1...@x2]
				if matrix[y][x] == undefined then continue
				if cb(matrix[y][x],x,y,argA,argB,argC) == false
					return false
		return true

	loopRect: (cb,argA,argB,argC)->
		for y in [@y1...@y2]
			for x in [@x1...@x2]
				if cb(x,y,argA,argB,argC) == false
					return false
		return true


# tile class, added as items in grid
class Tile extends Rect
	constructor: (opt)->
		opt.x2 = opt.width
		opt.y2 = opt.height
		super(opt)
		@item = opt.item
		@rect = opt.rect || null
		# if @x2 == 0 + @y2  0 || @x1 < 0 || @y1 < 0
		# 	throw new Error 'bad tile.'

	setXY: (x,y)->
		@rect.set(x,x+@x2,y,y+@y2)


# main grid class
class TileGrid extends Rect
	constructor: (opt)->

		super()


		@offset_x = 0
		@offset_y = 0
		
		
		@matrix = [] #2d matrix array that contains references to items in the list.
		@item_list = [] # a list of items.
		@removed = []
		@full = new Rect() # keep track of what portion of the matrix is full.
		@full.count_x = []
		@full.count_y = []
		
		@set(0,opt.width,0,opt.height)
		

	# clear one coordinate from matrix
	clearCoord: (item,x,y)=>
		if @matrix[y][x]
			@decrY(y)
			@decrX(x)
		@matrix[y][x] = null
		return true


	isItemNull: (item)=>
		item == null

	isCoordEmpty: (x,y)=>
		@matrix[y][x] == null

	# set the coordinate item
	setCoordItem: (item,x,y,new_item)=>
		if item then throw new Error 'setCoord, coord taken ['+x+','+y+'] by '+item
		@matrix[y][x] = [new_item,x-new_item.rect.x1,y-new_item.rect.y1]
		@incrY(y)
		@incrX(x)

	# (perf) decrease full row y value
	decrY: (y)->
		@full.count_y[y]--
		if @full.y1 > y
			@full.y1 = y

		if @full.y2 > y
			@full.y2 = y

	# (perf) decrease
	decrX: (x)->
		@full.count_x[x]--
		if @full.x1 > x
			@full.x1 = x

		if @full.x2 > x
			@full.x2 = x

	# increment row full value and count (all x items on y)
	incrY: (y)->
		@full.count_y[y]++
		if @full.count_y[y] == @width
			for yi in [@full.y2...@y2]
				if @full.count_y[yi] != @width
					@full.y2 = yi
					break
				else if yi < @full.y1
					@full.y1 = yi
	
	# increment column full value and count (all y items on x)
	incrX: (x)->
		@full.count_x[x]++
		if @full.count_x[x] == @width
			for xi in [@full.x2...@x2]
				if @full.count_x[xi] != @height
					@full.x2 = xi
					break
				else if xi < @full.x1
					@full.x1 = xi




	# clear all items in a rect from the matrix
	clearRect: (rect)->
		rect.loopMatrix(@matrix,@clearItem)


	# clear one item from the matrix
	clearItem: (spot,x,y)=>
		if !spot then return false
		item = spot[0]
		sx = x - spot[1]
		sy = y - spot[2]
		if !item.rect
			throw new Error 'cant clear item, item has no rect. '+sx+','+sy

		for iy in [sy...sy+item.y2]
			for ix in [sx...sx+item.x2]
				@clearCoord(item,ix,iy)

		item.rect = null
		# @removed.push item
		

	# clear a row from matrix
	clearY: (y)->
		for item,x in @matrix[y]
			@clearItem @matrix[y][x],x,y

	# clear a column from matrix
	clearX: (x)->
		for row,y in @matrix
			@clearItem row[x],x,y

	# insert column(s) into matrix
	insertX: (pos,count)->
		pos = _clamp(0,@)
		for y in @matrix
			for i in [0...count]
				y.splice(pos,0,null)

	# insert row(s) into matrix
	insertY: (pos,count)->
		pos = _clamp(0,@y2)
		if pos > 0
			for x in [0...@x2]
				if @matrix[x][pos] == @matrix[x][pos-1]
					@freeSpot(x,pos)
		
		for i in [0...count]
			@matrix.splice(pos,0,new Array(@x2).fill(null))

	# set new bounds for matrix.
	set: (x1,x2,y1,y2)->
		if !@height
			@height = 0
		if !@width
			@width = 0
		if @x1 == undefined
			return super(x1,x2,y1,y2)


		diff = new Rect
			x1: x1 - @x1
			x2: x2 - @x2
			y1: y1 - @y1
			y2: y2 - @y2

		if (diff.y1 - diff.y2) > @height
			throw new Error 'set: Y out of bounds'

		if (diff.x1 - diff.x2) > @width
			throw new Error 'set: X out of bounds'
		
		
		#diff X2
		if diff.x2 > 0
			for i in [0...diff.x2]
				@full.count_x.push 0
				for y in @matrix
					y.push null
		else if diff.x2 < 0
			for i in [0...diff.x2]
				# log @matrix[0].length
				# log @x2-1+i
				@clearX(@x2-1+i)
				@full.count_x.pop()
				for y in @matrix
					y.pop()
		@x2 = x2

		#diff X1
		if diff.x1 < 0
			for i in [0...diff.x1]
				@full.count_x.unshift 0
				@full.x2++
				@full.x1++
				@offset_x--
				for row in @matrix
					row.unshift null
						

		else if diff.x1 > 0
			for i in [0...diff.x1]
				@clearX(0)
				@full.x2--
				@full.x1--
				@offset_x++
				@full.count_x.shift()
				for row in @matrix
					row.shift()
		@x1 = x1


		#diff Y2
		if diff.y2 > 0
			for i in [0...diff.y2]
				@full.count_y.push 0
				@matrix.push new Array(@x2-@x1).fill(null)
		else if diff.y2 < 0
			for i in [0...diff.y2]
				@clearY(@y2-1+i)
				@full.count_y.pop()
				@matrix.pop()
			# for i in [0...diff.y2]
		@y2 = y2


		#diff Y1
		if diff.y1 > 0
			for i in [0...diff.y1]
				@clearY(0)
				@full.y2--
				@full.y1--
				@offset_y++
				@full.count_y.shift()
				@matrix.shift()
		else if diff.y1 < 0
			for i in [0...diff.y1]
				@offset_y--
				@full.y2++
				@full.y1++
				@full.count_y.unshift 0
				@full.x1 = 0
				@full.x2 = 0
				@matrix.unshift new Array(@x2-@x1).fill(null)
		@y1 = y1

		@normalize()

		@width = @x2
		@height = @y2



	pad: (x1,x2,y1,y2)->
		@set(@x1+x1,@x2+x2,@y1+y1,@y2+y2)



	# check empty rect
	checkEmptyRect: (x,y,rect,empty_rect)=>
		empty_rect.set(x,x+rect.x2,y,y+rect.y2)

		# continue search.
		if @matrix[empty_rect.y2-1][empty_rect.x2-1]
			empty_rect.set()
			return true
		
		if empty_rect.loopMatrix(@matrix,@isItemNull) == true
			return false
		else
			empty_rect.set()


	# find a free rect within bounds, if no rect is found, return null
	# rect x1 and y1 must be normalized.
	findEmptyRect: (rect,bounds,cb)->
		rect.normalize()

		# limit size by the rect that we are trying to find (no overflow searches)
		bounds.x2 -= rect.x2 - 1
		bounds.y2 -= rect.y2 - 1
		

		empty_rect = new Rect

		# log 'bounds',bounds

		
		bounds.loopRect(@checkEmptyRect,rect,empty_rect)

		# log bounds.x1

		if empty_rect.x2 != 0 && empty_rect.y2 != 0
			return empty_rect
		else
			return null


	# add an item with a specific bound to look for free space, if no free space, the cb will be called and space will be searched again but without a callback. if no callback is provided will either place the item or return false.
	addItem: (item,bound,cb)->
		# log 'addItem',item
		found_rect = @findEmptyRect(item,bound)
		if !found_rect
			return false
		else
			item.rect = found_rect
			item.rect.loopMatrix(@matrix,@setCoordItem,item)
			@item_list.push item
			# log 'full',@full
			return true

	log: ->
		# +'|'+(x[1]+','+x[2])
		console.log '-----------------\n\n'
		for y in @matrix
			str = y.map (x)->
				return x && String(x[0].item.n) || '  -  '
			console.log(str.join('     ')+'\n\n')
		console.log '-----------------'





module.exports = {Rect,Tile,TileGrid}