extends Effect
class_name SteeringEffect

@export var car: Vehicle
@export var level: int

@export var MAX_OFFSET_ANGLE = 5.0
@export var MIN_DELAY = 5.0
@export var MAX_DELAY = 10.0

var delay = 5.0
var offset = 0.0

func apply(delta: float, drunk_level: int):
	var scalar = get_scalar(drunk_level)
	delay -= delta
	if (delay <= 0):
		delay = randf_range(MIN_DELAY, MAX_DELAY)
		offset = scalar * randf_range(0.0, deg_to_rad(MAX_OFFSET_ANGLE)) * sign(randf_range(-1.0, 1.0))

	car.steering_input += offset

func get_scalar(drunk_level: float) -> float:
	if (drunk_level < level):
		return 0.0
	return (drunk_level-level)/level
