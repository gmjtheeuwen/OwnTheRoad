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

func physics_update(delta: float, drunk_level: int = 0):
	player_car.brake_input = Input.get_action_strength("down")
	player_car.steering_input = Input.get_action_strength("left") - Input.get_action_strength("right")	
	player_car.throttle_input = pow(Input.get_action_strength("up"), 2.0)
	
	if player_car.current_gear == -1:
		player_car.brake_input = Input.get_action_strength("up")
		player_car.throttle_input = Input.get_action_strength("down")
	
	for effect in effects:
		effect.apply(delta, drunk_level)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and head and camera:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		head.rotation.y = clamp(head.rotation.y, deg_to_rad(-30), deg_to_rad(30))
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(30))

func on_car_exited():
	player.position = player_car.position + Vector3(-1.5, 0, 0)
	player.collision.disabled = false
	transitioned.emit(self, "idle")

func on_phone_entered():
	print("phone entered")
	transitioned.emit(self, "driving_phone")
