extends Effect
class_name ThrottleEffect

@export var car: Vehicle
@export var level: int = 8

@export var BASE_OFFSET = 0.1
@export var THROTTLE_SPEED = 0.05
@export var MIN_DELAY = 5.0
@export var MAX_DELAY = 10.0

var delay = 0.0
var target_offset = 0.0
var current_offset = 0.0

func apply(delta: float, drunk_level: int):
	var scalar = get_scalar(drunk_level)
	delay -= delta
	if (delay < 0):
		delay = randf_range(MIN_DELAY, MAX_DELAY)
		target_offset = randf_range(-1.0, 1.0)*scalar*BASE_OFFSET
	
	current_offset = move_toward(current_offset, target_offset, delta * scalar * THROTTLE_SPEED)
	car.throttle_input += current_offset
	
func get_scalar(drunk_level: float) -> float:
	if (drunk_level < level):
		return 0.0
	return drunk_level/level
