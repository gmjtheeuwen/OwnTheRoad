extends State
class_name Walking

@export var headbob_frequency:= 10.0
@export var headbob_amplitude:= 0.1
@export var player: CharacterBody3D

var headbob_time = 0.0

func headbob(delta) -> Vector3:
	var new_position = Vector3.ZERO
	headbob_time += delta
	new_position.x = cos(headbob_time*headbob_frequency/2) * headbob_amplitude
	new_position.y = sin(headbob_time*headbob_frequency) * headbob_amplitude
	return new_position

func physics_update(delta: float):
	if player.velocity.length() > 0:
		player.camera.transform.origin = headbob(delta)
	else:
		transitioned.emit(self, "idle")
