class_name Grid3х3

var grid : Array = []

func _init(_array: Array):
	for row in _array:
		grid+=row

func get_cell(x: int,y: int):
	return grid[y * 3 + x]

func set_cell(x: int,y: int,v: int):
	grid[y * 3 + x] = v

func get_array():
	return grid
