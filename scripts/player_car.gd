extends CharacterBody3D

signal car_entered
signal car_exited
signal car_stopped
signal phone_entered
signal phone_exited

@onready var label = $Area3D/InputLabel
@onready var camera = $Head/Camera
@onready var stop_button = $StopCarButton

var playerInCar := false
var playerNextToDoor := false

func _ready() -> void:
	label.visible = false
	stop_button.visible = false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		label.visible = true
		playerNextToDoor = true

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		label.visible = false
		playerNextToDoor = false
		
func _on_fade_out_completed():
	car_stopped.emit()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if playerInCar:
			playerInCar = false
			stop_button.visible = false
			car_exited.emit()
		elif playerNextToDoor:
			playerInCar = true
			stop_button.visible = true
			playerNextToDoor = false
			label.visible = false
			car_entered.emit()
			
	move_and_slide()
func on_phone_entered():
	phone_entered.emit()

func on_phone_exited():
	phone_exited.emit()
	
