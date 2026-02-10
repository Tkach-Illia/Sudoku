extends Control
class_name SingleGrid

func setup(_grid: Array):
	add_child(Main.createGrid(_grid, preload("res://scenes/single_number.tscn")))
	return self
