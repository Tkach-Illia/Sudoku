extends Control
class_name SingleGrid

var grid: MyGrid

func setup(_grid: Array):
	grid = MyGrid.new(_grid)
	add_child(Main.createGrid(_grid, preload("res://scenes/single_number.tscn")))
	return self
