extends Control

@export var board_size: Array[int] = [2,3]
@export var numbers: Array = [
  [
	[
	  [3, 7, 1],
	  [9, 4, 6],
	  [2, 8, 5]
	],
	[
	  [6, 2, 8],
	  [1, 5, 9],
	  [7, 3, 4]
	],
	[
	  [4, 9, 5],
	  [8, 3, 2],
	  [6, 1, 7]
	]
  ],
  [
	[
	  [8, 1, 4],
	  [3, 6, 7],
	  [9, 5, 2]
	],
	[
	  [5, 6, 3],
	  [2, 8, 1],
	  [4, 7, 9]
	],
	[
	  [7, 2, 9],
	  [4, 1, 5],
	  [8, 6, 3]
	]
  ]
]


func _ready() -> void:
	add_child(Main.createGrid(numbers, preload("res://scenes/singe_grid.tscn")))
