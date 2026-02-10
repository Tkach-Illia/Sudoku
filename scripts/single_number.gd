extends PanelContainer
class_name SingleNumber

var number_value : int = 0
var coords: Array = [0, 0]
var is_changable: bool = true
var is_hover: bool = false

func setup(data: MyData):
	number_value = data.getNumber()
	coords = data.getCords()
	is_changable = data.getChangable()
	updateLabel()
	EventBus.changeNumber.connect(_update_number)
	return self

func _on_mouse_entered() -> void:
	if is_changable:
		is_hover = true

func _on_mouse_exited() -> void:
	if is_changable:
		is_hover = false

func _on_gui_input(event: InputEvent) -> void:
	if is_hover and event is InputEventMouseButton:
		if event.button_index == 1 and event.is_pressed():
			print(number_value, coords)
			EventBus.showKeyboard.emit(number_value, coords)

func _update_number(_number: int, _coords: Array):
	if coords == _coords:
		number_value = _number
		updateLabel()

func updateLabel():
	if is_changable:
		set_self_modulate(Color())
	if number_value == 0:
		$Label.set_self_modulate(Color())
	else:
		$Label.set_self_modulate(Color(1,1,1))
	$Label.set_text(str(number_value))
