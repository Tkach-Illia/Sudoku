extends Node2D
class_name Main

static var row_size: int = 2

@export var board_node: Control
var board_array: Array
var callback_array: Array
var allowed_numbers: Array
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
	init_allowed_numbers()
	board_array = fill_board()
	board_node.setup(board_array)
	var pair: Array[int] = [7,7]
	print(7/3)
	var i = 8
	print([pair[0]/row_size,i/row_size],[pair[0]%row_size,i%row_size])
	
func init_allowed_numbers():
	for i in row_size*row_size:
		allowed_numbers.append(i+1)

static func createGrid(array :Array, target_class: Resource):
	var rows = VBoxContainer.new()
	
	for row in array:
		var single_row = HBoxContainer.new()
		
		for element in row:
			var single_el = target_class.instantiate()
			single_row.add_child(single_el.setup(element))
			
		rows.add_child(single_row)
		
	return rows

#static func is_valid_sequence(arr: Array):
	#return (arr.filter(func(element): return count(arr,element)>1).size()==0)

static func count(arr: Array, element: int):
	var count: int = 0
	
	for i in arr:
		if i == element:
			count+=1
			
	return count

func generate_board_pairs():
	var board: Array[Array]
	
	for row in row_size*row_size:
		for col in row_size*row_size:
			board.append([row, col])
		
	return board
	
func generate_board(element):
	var board: Array[Array]
	
	for row in row_size:
		var new_row: Array = []
		
		for col in row_size:
			new_row.append(element)
			
		board.append(new_row)
		
	return board

func fill_board():
	var pairs: Array[Array] = generate_board_pairs()
	var board: Array[Array] = generate_board(generate_board(0))
	print(board)
	while not pairs.is_empty():
		var pair: Array = pairs.pick_random()
		var valid_numbers = get_valid_numbers(board, pair)
		if valid_numbers.is_empty():
			print("fail")
			return board
		board[pair[0]/row_size][pair[1]/row_size][pair[0]%row_size][pair[1]%row_size] = valid_numbers.pick_random()
		pairs.erase(pair)
	return board

func get_valid_numbers(board: Array[Array], pair: Array):
	var valid_numbers: Array = []
	var check_vert: Array = []
	var check_horiz: Array = []
	var check_grid: Array = []
	
	for i in row_size*row_size:
		check_vert.append(board[pair[0]/row_size][i/row_size][pair[0]%row_size][i%row_size])
		check_horiz.append(board[i/row_size][pair[1]/row_size][i%row_size][pair[1]%row_size])
	
	for i in row_size:
		for j in row_size:
			check_grid.append(board[pair[0]/row_size][pair[1]/row_size][i][j])
			
	for number in allowed_numbers:
		if check_number_in_sequence(check_vert,number) and check_number_in_sequence(check_horiz, number) and check_number_in_sequence(check_grid, number):
			valid_numbers.append(number)
	return valid_numbers
	
func check_number_in_sequence(arr: Array, number: int):
	return arr.filter(func(i): return i==number).size() == 0
