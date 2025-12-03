extends StaticBody3D

@export var speed : float = 20.0

var playerCarStopped = false

func _ready() -> void:
	GameEvents.stop_button_pressed.connect(on_stop_pressed)

func _process(delta: float) -> void:
	MoveObstacleCars(delta)
	
func MoveObstacleCars(delta) -> void:
		position.z += speed * delta

func on_stop_pressed() -> void:
	playerCarStopped = true
