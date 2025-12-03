extends State
class_name Driving

@export var player_car: CharacterBody3D
@export var player: CharacterBody3D
@export var max_speed = 10.0
@export var turn_speed = 4.0
var velocityX = 0.0

func _ready() -> void:
	if (player):
		player.get_node("CollisionShape3D")
		

func physics_update(delta: float):
	var direction = Input.get_axis("ui_left", "ui_right")
	velocityX = move_toward(velocityX, direction * max_speed, delta*turn_speed)
	player_car.position.x += velocityX
	player_car.move_and_slide()
