extends State
class_name Driving_Phone

@export var player: CharacterBody3D
@export var player_car: Vehicle
var normal_fov := 75.0
@export var phone_fov := 50.0
var fov_speed := 4.0

var camera: Camera3D

func enter():
	player.open_phone()
	player.phone_pressed.connect(on_phone_pressed)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	camera = player_car.get_node("Head/Camera")
	player.set_active_camera(camera)

func physics_update(delta: float, _drunk_level: int = 0):
	if(player_car):
		camera.fov = lerp(camera.fov, phone_fov, delta * fov_speed)
		

func exit():
	if player.phone_pressed.is_connected(on_phone_pressed):
		player.phone_pressed.disconnect(on_phone_pressed)
	player.close_phone()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func on_phone_pressed():
	transitioned.emit(self, "driving")

func on_car_exited():
	player.close_phone()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player.position = player_car.position + Vector3(1.5, 0, 0)
	player.collision.disabled = false
	transitioned.emit(self, "idle")
