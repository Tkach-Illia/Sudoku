class_name MyGrid

var row_size: int
var grid: Array = []

func _init(_array: Array = get_blank()):
	grid = set_grid_from_array2(_array)

func get_cell(x: int,y: int):
	return grid[y * row_size + x]

func set_cell(x: int,y: int,v: int):
	grid[y * row_size + x] = v

func get_array():
	return grid

func get_stucked_array():
	var arr: Array = []
	for i in row_size:
		arr+=[grid.slice(i*row_size,(i+1)*row_size)]
	return arr

func get_blank():
	var array: Array = []
	for el in Main.row_size*Main.row_size:
		array.append(1)
	return array

func set_grid_from_array2(arr: Array):
	var new_grid: Array = []
	for i in arr:
		for j in i:
			new_grid.append(j)
	return new_grid
