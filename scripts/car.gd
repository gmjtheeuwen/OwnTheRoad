extends StaticBody3D

@export var speed : float = 20.0

func _process(delta: float) -> void:
	position.z += speed * delta
