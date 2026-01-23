extends Effect
class_name SteeringEffect

@export var car: Vehicle
@export var level: int = 8

@export var BASE_OFFSET_ANGLE = 3.0
@export var TURN_SPEED = 0.2
@export var MIN_DELAY = 2.5
@export var MAX_DELAY = 10.0

var delay = 5.0
var target_offset = 0.0
var current_offset = 0.0

func apply(delta: float, drunk_level: int):
	var scalar = get_scalar(drunk_level)
	delay -= delta
	if (delay <= 0):
		delay = randf_range(MIN_DELAY, MAX_DELAY)
		target_offset = scalar * randf_range(0.0, deg_to_rad(BASE_OFFSET_ANGLE)) * sign(randf_range(-1.0, 1.0))
	current_offset = move_toward(current_offset, target_offset, delta * scalar * TURN_SPEED)
	car.steering_input += current_offset

func get_scalar(drunk_level: float) -> float:
	if (drunk_level < level):
		return 0.0
	return (drunk_level-level)/level
