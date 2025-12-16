extends State
class_name Driving

@export var player_car: CharacterBody3D
@export var player: CharacterBody3D
@export var max_speed = 0.1
@export var turn_speed = 0.3
@export var pull_over_speed = 0.05
var velocityX = 0.0
var car_stopped = false

func enter():
	if (player):
		player.get_node("Collision").disabled = true
		player_car.get_node("Camera").set_current(true)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func physics_update(delta: float):
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

func _on_stop_3d_button_pressed() -> void:
	car_stopped = true

func on_phone_entered():
	print("phone entered")
	transitioned.emit(self, "driving_phone")
