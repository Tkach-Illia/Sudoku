extends Node2D
class_name Main

@export var board_size: Array[int] = [2,3]
var board_array: Array
var callback_array: Array
@export var numbers: Array = [
  [
	[
	  [3, 7, 2],
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
	print(numbers[0][0])
	var grid = Grid3х3.new(numbers[0][0])
	print(grid.is_valid())

static func createGrid(array :Array, target_class: Resource):
	var rows = VBoxContainer.new()
	for row in array:
		var single_row = HBoxContainer.new()
		for element in row:
			var single_grid = target_class.instantiate()
			single_row.add_child(single_grid.setup(element))
		rows.add_child(single_row)
	return rows
