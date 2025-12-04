extends CharacterBody3D

signal car_entered
signal car_exited

@onready var label = $Area3D/InputLabel
@onready var camera = $Camera

var playerInCar := false
var playerNextToDoor := false

func _ready() -> void:
	label.visible = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		label.visible = true
		playerNextToDoor = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		label.visible = false
		playerNextToDoor = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if playerInCar:
			playerInCar = false
			
			car_exited.emit()
		elif playerNextToDoor:
			playerInCar = true
			playerNextToDoor = false
			label.visible = false
			print("player_car")
			car_entered.emit()
			
	move_and_slide()
