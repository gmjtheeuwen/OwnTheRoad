extends State
class_name Driving

@export var player_car: CharacterBody3D
@export var player: CharacterBody3D
@export var max_speed = 0.3
@export var turn_speed = 0.5
var velocityX = 0.0

func enter():
	if (player):
		player.get_node("Collision").disabled = true
		player_car.get_node("Camera").set_current(true)

func exit():
	if (player):
		player.get_node("Collision").disabled = false
		player.get_node("Head/Camera").set_current(true)

func physics_update(delta: float):
	var direction = Input.get_axis("ui_left", "ui_right")
	velocityX = move_toward(velocityX, direction * max_speed, delta * turn_speed)
	player_car.position.x += velocityX


func on_car_exited():
	player.position = player_car.position + Vector3(-1.5, 0, 0)
	player.collision.disabled = false
	transitioned.emit(self, "idle")
