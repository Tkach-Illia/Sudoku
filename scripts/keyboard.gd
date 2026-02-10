extends GridContainer

var coords: Array
var number: int

func _ready() -> void:
	EventBus.showKeyboard.connect(_show_self)
	EventBus.returnValidNumbers.connect(_fill_keyboard)

func _show_self(_number: int, _coords:Array):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	number=_number
	coords=_coords
	EventBus.initCalcValidNumbers.emit(coords)

func _fill_keyboard(numbers: Array):
	print(numbers)
	for number in numbers:
		var btn: Button = Button.new()
		btn.text = str(number)
		btn.pressed.connect(func(): return int(self.text))
		add_child(btn)

func button_pressed(_number: int):
	print(number)
