extends Control

@export var numbers: Array

func setup(board_array: Array) -> void:
	add_child(Main.createGrid(board_array, preload("res://scenes/singe_grid.tscn")))
	print(get_children())

func set_numbers(array: Array):
	numbers = array
