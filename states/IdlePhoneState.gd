extends State
class_name Idle_Phone

@export var headbob_frequency:= 12.0
@export var headbob_amplitude:= 0.1
@export var walking_speed = 5.0
@export var player: CharacterBody3D

var camera: Camera3D
var head: Node3D

var headbob_time = 0.0

@export var phone_fov := 50.0
var fov_speed := 4.0

func enter():
	if (player):
		player.open_phone()
		player.phone_pressed.connect(on_phone_pressed)
		camera = player.get_node("Head/Camera")
		head = player.get_node("Head")
		player.set_active_camera(camera)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
func on_car_entered():
	player.collision.disabled = true
	player.position = Vector3(0, -10, 0)
	transitioned.emit(self, "driving")
	

func exit():
	if player.phone_pressed.is_connected(on_phone_pressed):
		player.phone_pressed.disconnect(on_phone_pressed)
	player.close_phone()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func on_phone_pressed():
	transitioned.emit(self, "idle")

func physics_update(delta: float, _drunk_level: int = 0):
	camera.fov = lerp(camera.fov, phone_fov, delta * fov_speed)
