extends Effect
class_name BrakeEffect

@export var car: Vehicle
@export var level: int = 8

@export var BASE_OFFSET = 0.8

var delay = 0.0

func apply(_delta: float, drunk_level: int):
	var scalar = get_scalar(drunk_level)

	car.brake_input *= pow(BASE_OFFSET, scalar)
	
func get_scalar(drunk_level: float) -> float:
	if (drunk_level < level):
		return 0.0
	return drunk_level/level
