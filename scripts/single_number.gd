extends PanelContainer
class_name SingleNumber

var number_value : int = 0

func setup(_number: int):
	number_value = _number
	$Label.set_text(str(number_value))
	return self

func create_callback():
	pass

func changeNumber(new_number):
	pass
