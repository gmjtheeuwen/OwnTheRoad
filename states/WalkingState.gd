extends State
class_name Walking

@export var headbob_frequency:= 12.0
@export var headbob_amplitude:= 0.1
@export var walking_speed = 5.0
@export var player: CharacterBody3D

var headbob_time = 0.0

func headbob(delta) -> Vector3:
	var new_position = Vector3.ZERO
	headbob_time += delta
	new_position.x = cos(headbob_time*headbob_frequency/2) * headbob_amplitude
	new_position.y = sin(headbob_time*headbob_frequency) * headbob_amplitude
	return new_position

func physics_update(delta: float, _drunk_level: int = 0):
	if not player.is_on_floor():
		player.velocity.y += player.get_gravity().y*delta
	
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		player.velocity.x = direction.x * walking_speed
		player.velocity.z = direction.z * walking_speed
		player.camera.transform.origin = headbob(delta)
	else:
		player.velocity.x = 0.0
		player.velocity.z = 0.0
		transitioned.emit(self, "idle")

func on_car_entered():
	player.collision.disabled = true
	player.position = Vector3(0, -10, 0)
	transitioned.emit(self, "driving")
