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
	print(board_array)
	board_node.setup(board_array)
	
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
	
func generate_board():
	var board :Array[Array]= []
	for i in row_size:
		var row := []
		for j in row_size:
			row.append(generate_empty_grid())
		board.append(row)
	return board

	
func generate_empty_grid():
	var grid :Array[Array]= []
	for i in row_size:
		var row := []
		for j in row_size:
			row.append(0)
		grid.append(row)
	return grid
	
func fill_board():
	var pairs: Array = generate_board_pairs()
	var board: Array = generate_board()
	
	pairs.shuffle()
	var i = 0
	try_seed(pairs, board)
	print(board)
	return board

func try_seed(pairs: Array, board:Array):
	if not has_zero(board):
		return true
	var used_pairs: Array[Array] = []
	for pair in pairs:
		for value in get_valid_numbers(board, pair):
				
			board[pair[0]/row_size as int][pair[1]/row_size as int][pair[0]%row_size as int][pair[1]%row_size as int] = value
			
			var result = try_seed(pairs.filter(func(el): return el != pair),board)
			if result:
				return true
					
			board[pair[0]/row_size as int][pair[1]/row_size as int][pair[0]%row_size as int][pair[1]%row_size as int] = 0
			used_pairs.append(pair)

	return false

func test(pairs: Array, board:Array):
	var used_pairs: Array[Array] = []
	
	var exit: int = 0
	while not pairs.is_empty() and exit<500:
		var pair: Array = pairs.pick_random()
		var valid_numbers = get_valid_numbers(board, pair)
		exit+=1
		if valid_numbers.is_empty():
			#if used_pairs.is_empty():
				print("fail")
				return null
			#var last_used_pair: Array = used_pairs[-1]
			#print(used_pairs[-1])
			#used_pairs.erase(last_used_pair)
			#board[last_used_pair[0]/row_size as int][last_used_pair[1]/row_size as int][last_used_pair[0]%row_size as int][last_used_pair[1]%row_size as int] = 0
			#pairs.append(last_used_pair)
		else:
			board[pair[0]/row_size as int][pair[1]/row_size as int][pair[0]%row_size as int][pair[1]%row_size as int] = valid_numbers.pick_random()
		
			pairs.erase(pair)
			used_pairs.append(pair)
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

func has_zero(array) -> bool:
	for i in array:
		for j in i:
			for k in j:
				for l in k:
					if l == 0:
						return true
	return false
