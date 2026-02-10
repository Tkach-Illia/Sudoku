extends Container

@export var but_container: GridContainer
var coords: Array
var number: int

func _ready() -> void:
	EventBus.showKeyboard.connect(_show_self)
	EventBus.returnValidNumbers.connect(_fill_keyboard)

func _show_self(_number: int, _coords:Array):
	for child in but_container.get_children():
		but_container.remove_child(child)
		child.queue_free()
	number=_number
	coords=_coords
	EventBus.initCalcValidNumbers.emit(coords)

func _fill_keyboard(numbers: Array):
	print(numbers)
	for number in numbers:
		var btn: Button = Button.new()
		btn.text = str(number)
		btn.pressed.connect(button_pressed.bind(number))
		print(but_container)
		but_container.add_child(btn)

func button_pressed(_number: int):
	EventBus.changeNumber.emit(_number, coords)


func _on_clear_pressed() -> void:
	EventBus.changeNumber.emit(0, coords)
