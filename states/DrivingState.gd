extends State
class_name Driving

@export var player_car: RigidBody3D
@export var player: CharacterBody3D
@export var max_speed = 0.1
@export var turn_speed = 0.3
@export var pull_over_speed = 0.05

var effects: Array = []

var velocityX = 0.0
var velocityZ = 0.0

var camera: Camera3D
var head: Node3D

const SENSITIVITY = 0.005

var normal_fov := 75.0
var fov_speed := 4.0

func enter():
	if (player):
		player.get_node("Collision").disabled = true
		camera = player_car.get_node("Head/Camera")
		head = player_car.get_node("Head")
		camera.set_current(true)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		initialize_effects()
		
func exit():
	player_car.brake_input = 0.0
	player_car.throttle_input = 0.0
	player_car.steering_input = 0.0

func initialize_effects():
	for child in get_children():
		if child is Effect:
			effects.append(child)

func physics_update(delta: float):
	var camera := player_car.get_node("Head/Camera")
	
	if(player_car):
		camera.fov = lerp(camera.fov, normal_fov, delta * fov_speed)
	if not car_stopped:
		var direction = Input.get_axis("ui_left", "ui_right")
		velocityX = move_toward(velocityX, direction * max_speed, delta * turn_speed)
		player_car.position.x += velocityX
	elif car_stopped:
		velocityX = move_toward(velocityX, pull_over_speed, delta * turn_speed)
		player_car.position.x += velocityX

func on_car_exited():
	player.position = player_car.position + Vector3(-1.5, 0, 0)
	player.collision.disabled = false
	transitioned.emit(self, "idle")

func on_phone_entered():
	print("phone entered")
	transitioned.emit(self, "driving_phone")
