extends State
class_name Idle		

@export var player: CharacterBody3D
@export var normal_fov : float = 75
var fov_speed := 4.0

var camera: Camera3D

func enter():
	if (player):
		player.phone_pressed.connect(on_phone_pressed)
		camera = player.get_node("Head/Camera")
		player.get_node("Collision").disabled = false
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		player.set_active_camera(camera)

func physics_update(_delta: float, _drunk_level: int = 0):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		transitioned.emit(self, "walking")
	
	if camera.fov != normal_fov:
		camera.fov = lerp(camera.fov, normal_fov, _delta * fov_speed)

func on_car_entered():
	player.collision.disabled = true
	player.position = Vector3(0, -10, 0)
	transitioned.emit(self, "driving")

func exit():
	if player.phone_pressed.is_connected(on_phone_pressed):
		player.phone_pressed.disconnect(on_phone_pressed)
		
func on_phone_pressed():
	transitioned.emit(self, "idle_phone")
