extends CharacterBody3D

@export var maxSpeed = 10.0
@export var turnSpeed = 0.2
var velocityX = 0.0
var carIsActive = true

func _ready() -> void:
	GameEvents.stop_button_pressed.connect(on_stop_pressed)

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity = get_gravity() * delta
	
	if carIsActive:
		var direction = Input.get_axis("ui_left", "ui_right")
		velocityX = move_toward(velocityX, direction * maxSpeed, turnSpeed)
		position.x += velocityX * delta
		move_and_slide()

func on_stop_pressed() -> void:
	carIsActive = false
