class_name Grid3х3

var grid : Array = []

func _init(_array: Array):
	for row in _array:
		grid+=row
	print(grid)

func get_cell(x: int,y: int):
	return grid[y * 3 + x]

func set_cell(x: int,y: int,v: int):
	grid[y * 3 + x] = v

func is_valid():
	return (grid.filter(func(element): return count(grid,element)>1).size()==0)

func count(arr: Array, element: int):
	var count: int = 0
	for i in arr:
		if i == element:
			count+=1
	return count
