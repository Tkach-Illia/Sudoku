extends Node2D
class_name Main

static var row_size: int = 3

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

func try_seed(pairs: Array, board: Array) -> bool:
	if pairs.is_empty():
		return true

	var best_pair = null
	var best_options := []

	for p in pairs:
		var options :Array = get_valid_numbers(board, p)
		if options.is_empty():
			return false
		if best_pair == null or options.size() < best_options.size():
			best_pair = p
			best_options = options
		if best_options.size() == 1:
			break

	var bx: int= best_pair[0] / row_size
	var by: int = best_pair[1] / row_size
	var cx: int = best_pair[0] % row_size
	var cy: int = best_pair[1] % row_size

	for value in best_options:
		board[bx][by][cx][cy] = value

		var next_pairs := pairs.duplicate()
		next_pairs.erase(best_pair)

		if try_seed(next_pairs, board):
			return true

		board[bx][by][cx][cy] = 0

	return false

func get_valid_numbers(board: Array, pair: Array) -> Array:
	var valid_numbers: Array = []

	var bx :int = pair[0] / row_size
	var by :int = pair[1] / row_size
	var cx :int = pair[0] % row_size
	var cy :int = pair[1] % row_size

	for number in allowed_numbers:
		var is_ok := true

		for i in row_size * row_size:
			if board[bx][i / row_size][cx][i % row_size] == number:
				is_ok = false
				break
			if board[i / row_size][by][i % row_size][cy] == number:
				is_ok = false
				break

		if not is_ok:
			continue

		for i in row_size:
			for j in row_size:
				if board[bx][by][i][j] == number:
					is_ok = false
					break
			if not is_ok:
				break

		if is_ok:
			valid_numbers.append(number)

	return valid_numbers
