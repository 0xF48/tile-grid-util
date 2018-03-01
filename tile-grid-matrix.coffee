#a small and performant javascript library that manages a tile grid matrix with arbitrary data.


DEFAULT_OPT = 
	width: 3
	height: 3


class TileGrid
	constructor: (opt)->
		opt = Object.assign DEFAULT_OPT,opt
		@matrix = []
		@item_list = []
		@item_map = {}
		@width = opt.width
		@height = opt.height


	freeSpot: (row,col)->


	setWidth: (width,dir)->
		if !dir then dir = 1
		diff = width - @width
		if !diff then return @matrix
	
		for r in @matrix
			if diff > 0
				if dir >= 0
					for i in [0...diff]
						r.push null
				else
					for i in [0...diff]
						r.unshift null
			else
				if dir >= 0
					for i in [0...diff]
						@freeSpot(r,@width-i)
					r = r.slice(0,width)
				else
					for i in [0...diff]
						@freeSpot(r,i)
					r = r.slice(-diff,width)

		@width = width
		return @matrix

	
	setHeight: (height,dir)->
		if !dir
			dir = 1


		return @matrix



	addListItem: (item,key)->
		@item_map[key] = item
		@item_list[@item_list.length] = item


	# pos keys: 0: 'top', 1: ''
	addMatrixKey: (key)->



	# hide an item from the matrix.
	removeMatrixKey: (key)->




module.exports = TileGrid