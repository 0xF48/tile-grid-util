#javascript utility library to manage tile grids with arbitrary data.


DEFAULT_OPT = 
	width: 3
	height: 3


class TileGrid
	constructor: (opt)->
		opt = Object.assign DEFAULT_OPT,opt
		@matrix = []
		@item_list = []
		@item_map = new Map
		@width = opt.width
		@height = 0
		@setHeight(opt.height)


	freeSpot: (x,y)->
		if !@matrix[x] || !@matrix[x][y] then return
		item = @matrix[x][y]
		for x in [item.x...item.x+item.w]
			for y in [item.y...item.y+item.h]
				@matrix[x][y] = null
		item._matrix = false
		delete item.x
		delete item.y


	freeItemSpot: (x,y,item)->
		for x in [x...x+item.w]
			for y in [y...y+item.h]
				@freeSpot(x,y)


	# freeItem: (item)->
	# 	for x in [item.x...x+item.w]
	# 		for y in [item.y...y+item.h]
	# 			@freeSpot(x,y)


	setWidth: (width,dir)->
		if !dir then dir = 1
		diff = width - @width
		if !diff then return @matrix
	
		for y,yi in @matrix
			if diff > 0
				if dir >= 0
					for i in [0...diff]
						y.push null
				else
					for i in [0...diff]
						y.unshift null
			else
				if dir > 0
					for i in [1..diff]
						@freeSpot(@width-i,y)
					@matrix[yi] = y.slice(0,width)
					
				else
					for i in [0...-diff]
						@freeSpot(i,y)
					@matrix[yi] = y.slice(-diff,@width)

		@width = width
		return @matrix



	setHeight: (height,dir)->
		if !dir then dir = 1
		diff = height - @height
		if !diff then return @matrix

		for i in [0...Math.abs(diff)]
			if diff > 0
				if dir > 0
					@matrix.push new Array(@width).fill(null)
				else
					@matrix.unshift new Array(@width).fill(null)
			else
				if dir > 0
					for x in [0...@matrix.length]
						@freeSpot(x,@matrix.length-1)
					@matrix.pop()
				else
					for x in [0...@matrix.length]
						@freeSpot(x,0)
					@matrix.shift()

		@height = height
		return @matrix

	
	getItem: (item)->
		_item = @item_map.get(item)
		if !_item
			throw new Error 'setItem: item not found.'
		return _item


	addItem: (item,w,h)->
		if w <= 0 || h <= 0 || !w || !h
			throw new Error 'invalid width/height'
		
		if typeof key != "string"
			throw new Error 'item key must be a string.'
		
		_item = {
			item: item
			w: w
			h: h
		}

		@item_map.set item,_item
		@item_list[@item_list.length] = _item




	forceFreeSpot: (x,y,w,h)->
		if @width < x+w
			return false
		
		if @height < y+h
			return false

		for x in [x...x+w]
			for y in [y...y+h]
				@freeSpot(x,y)

		return true

	


	isOpen: (x,y,w,h)->
		for x in [x...x+w]
			for y in [y...y+h]
				if matrix[x][y] != null
					return false
		return true


	setMatrixItem: (_item,x,y)->
		for x in [x...x+_item.w]
			for y in [y...y+_item.h]
				if @matrix[x][y] != null
					throw new Error 'setMatrixItem : bad x/y : '+x+','+y
				@matrix[x][y] = item

	
	addItemToMatrix: (item,x,y,freeup_cb)->
		_item = @getItem(item)
		@removeItemFromMatrix(_item)
		if x != null && y != null && x != undefined && y != undefined
			if @isOpen(x,y,_item.w,_item.h)
				@setMatrixItem(_item,x,y)
			else
				if freeup_cb
					freeup_cb(item,x,y)
					if @isOpen(x,y,_item.w,_item.h)
						@setMatrixItem(_item,x,y)
					else
						throw new Error 'could not add item to matrix, free-up callback failed.'
				else
					return false
					

	removeItemFromMatrix: (item)->
		if item._matrix
			@freeSpot(item.x,item.y)


	







	# hide an item from the matrix.
	removeMatrixKey: (key)->




module.exports = TileGrid