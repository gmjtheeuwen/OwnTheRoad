extends State
class_name Driving_Phone

@export var player: CharacterBody3D
@export var player_car: Vehicle
var normal_fov := 75.0
@export var phone_fov := 20.0
var fov_speed := 4.0

func physics_update(delta: float, _drunk_level: int = 0):
	var camera := player_car.get_node("Head/Camera")
	
	if(player_car):
		camera.fov = lerp(camera.fov, phone_fov, delta * fov_speed)
		
func on_car_exited():
	player.position = player_car.position + Vector3(1.5, 0, 0)
	player.collision.disabled = false
	transitioned.emit(self, "idle")

func on_phone_exited():
	print("phone exited")
	transitioned.emit(self, "driving")
