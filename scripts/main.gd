extends Node2D
class_name Main

static var max_number: int = 9
static var min_number: int = 1
static var row_size: int = 3

@export var board: Control
var board_array: Array
var callback_array: Array

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
	board_array = generate_board()
	print(board_array)
	board.setup(board_array)

static func createGrid(array :Array, target_class: Resource):
	var rows = VBoxContainer.new()
	
	for row in array:
		var single_row = HBoxContainer.new()
		
		for element in row:
			var single_el = target_class.instantiate()
			single_row.add_child(single_el.setup(element))
			
		rows.add_child(single_row)
		
	return rows

static func is_valid(arr: Array):
	return (arr.filter(func(element): return count(arr,element)>1).size()==0)

static func count(arr: Array, element: int):
	var count: int = 0
	
	for i in arr:
		if i == element:
			count+=1
			
	return count
	
func is_valid_number(arr: Array, number: int):
	return count(arr, number)>1

func generate_board():
	var board: Array[Array]
	
	for row in row_size:
		var new_row: Array = []
		
		for col in row_size:
			new_row.append(MyGrid.new())
			print(row*col)
			
		board.append(new_row)
		
	return board
