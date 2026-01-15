extends State
class_name Idle_Phone

@export var headbob_frequency:= 12.0
@export var headbob_amplitude:= 0.1
@export var walking_speed = 5.0
@export var player: CharacterBody3D

var camera: Camera3D
var head: Node3D

var headbob_time = 0.0
signal enable_phone
signal disable_phone

@export var phone_fov := 30.0
var fov_speed := 4.0

func enter():
	if (player):
		camera = player.get_node("Head/Camera")
		head = player.get_node("Head")
		camera.set_current(true)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		enable_phone.emit()

func physics_update(delta: float, drunk_level: int = 0):
	var camera := player.get_node("Head/Camera")
	
	if(player):
		camera.fov = lerp(camera.fov, phone_fov, delta * fov_speed)
		
	
	if Input.is_action_just_pressed("phone"):
		exit_phone()

func exit_phone():
	disable_phone.emit()
	transitioned.emit(self, "idle")
