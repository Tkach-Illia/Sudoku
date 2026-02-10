extends Node2D
class_name Main

static var row_size: int = 3

@export var board_node: Control
var sudoku_gen = SudokuGenerator.new()
var board_numbers: Array
var callback_array: Array
var allowed_numbers: Array

func _ready() -> void:
	allowed_numbers = sudoku_gen.getAllowedNumbers()
	board_numbers = sudoku_gen.fill_board()
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
					xc.append(MyData.new(board_numbers[i][j][k][l],[i,j,k,l], true))
				by.append(xc)
			bx.append(by)
		board.append(bx)
		
	return board

static func createGrid(array :Array, target_class: Resource):
	var rows = VBoxContainer.new()
	
	for row in array:
		var single_row = HBoxContainer.new()
		
		for element in row:
			var single_el = target_class.instantiate()
			single_row.add_child(single_el.setup(element))
			
		rows.add_child(single_row)
		
	return rows
