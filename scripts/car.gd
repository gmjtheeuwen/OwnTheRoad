extends StaticBody3D

@export var speed : float = 20.0

var playerCarStopped = false

func _ready() -> void:
	GameEvents.stop_button_pressed.connect(onStopPressed)

func _process(delta: float) -> void:
	MoveObstacleCars(delta)
	
func MoveObstacleCars(delta) -> void:
	
	if not playerCarStopped:
		position.z += speed * delta

func onStopPressed() -> void:
	playerCarStopped = true
