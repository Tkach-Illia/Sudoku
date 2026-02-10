class_name MyData

var number: int = 0
var coords: Array = []
var is_changable: bool

func _init(_number: int, _coords: Array, _is_changable: bool):
	number = _number
	coords = _coords
	is_changable = _is_changable

func getNumber():
	return number
	
func getCords():
	return coords
	
func getChangable():
	return is_changable
