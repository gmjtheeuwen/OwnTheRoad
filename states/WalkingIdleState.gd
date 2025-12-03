extends State
class_name Idle		

@export var player: CharacterBody3D
@export var player_car: CharacterBody3D
	

func physics_update(_delta: float):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		transitioned.emit(self, "walking")


func on_car_entered():
	player.collision.disabled = true
	player.position = Vector3(0, -10, 0)
	transitioned.emit(self, "driving")
