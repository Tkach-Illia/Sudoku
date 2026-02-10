extends Node2D
class_name Main

static var row_size: int = 3

@export var board_node: Control
var board_numbers: Array
var callback_array: Array
var allowed_numbers: Array

func _ready() -> void:
	init_allowed_numbers()
	board_numbers = fill_board()
	var board_array = generate_board_array(board_numbers)
	board_node.setup(board_array)

func generate_board_array(board_numbers: Array):
	var board: Array[Array]
	
	for i in board_numbers.size():
		var bx : Array = []
		for j in board_numbers[i].size():
			var by: Array = []
			for k in board_numbers[i][j].size():
				var xc: Array = []
				for l in board_numbers[i][j][k].size():
					xc.append(MyData.new(l,[i,j,k,l], true))
				by.append(xc)
			bx.append(by)
		board.append(bx)
		
	return board

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
		var row : Array = []
		for j in row_size:
			row.append(generate_empty_grid())
		board.append(row)
	return board

	
func generate_empty_grid():
	var grid :Array[Array]= []
	for i in row_size:
		var row :Array = []
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
