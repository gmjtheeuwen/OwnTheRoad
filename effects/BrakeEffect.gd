extends Effect
class_name BrakeEffect

@export var car: Vehicle
@export var level: int

@export var BASE_OFFSET = 0.8

var delay = 0.0
var offset = 0.0

func apply(_delta: float, drunk_level: int):
	var scalar = get_scalar(drunk_level)
	offset = randf()*scalar*BASE_OFFSET
	
	if (car.brake_input > 0.2):
		car.brake_input -= offset
		print(car.brake_input)
	
func get_scalar(drunk_level: float) -> float:
	if (drunk_level < level):
		return 0.0
	return drunk_level/level
