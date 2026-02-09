extends GridContainer
class_name SingleGrid

var grid: Array = [[0,0,0], [0,0,0], [0,0,0]]

func setup(_grid: Array):
	grid = _grid
	add_child(Main.createGrid(grid, preload("res://scenes/single_number.tscn")))
	return self
