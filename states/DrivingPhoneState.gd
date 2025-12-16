extends State
class_name Driving_Phone

@export var player: CharacterBody3D
@export var player_car: CharacterBody3D
var normal_fov := 75.0
@export var phone_fov := 20.0
var fov_speed := 4.0

func update(_delta: float):
	pass

func physics_update(delta: float):
	var camera := player_car.get_node("Head/Camera")
	
	if(player_car):
		camera.fov = lerp(camera.fov, phone_fov, delta * fov_speed)

func on_phone_exited():
	print("phone exited")
	transitioned.emit(self, "driving")
