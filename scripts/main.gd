extends Node2D
class_name Main

static func createGrid(array :Array, target_class: Resource):
	var rows = VBoxContainer.new()
	for row in array:
		var single_row = HBoxContainer.new()
		for element in row:
			var single_grid = target_class.instantiate()
			single_row.add_child(single_grid.setup(element))
		rows.add_child(single_row)
	return rows
