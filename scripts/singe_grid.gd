extends Control
class_name SingleGrid

var grid: MyGrid

func setup(_grid: MyGrid):
	grid = _grid
	add_child(Main.createGrid(grid.get_stucked_array(), preload("res://scenes/single_number.tscn")))
	return self
