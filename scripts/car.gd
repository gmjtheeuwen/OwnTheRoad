extends StaticBody3D

@export var speed : float = 25.0
@export var direction: Vector3i = Vector3i.FORWARD

func _process(delta: float) -> void:
	position.z += speed * delta

	if position.z >= 100:
		process_mode = Node.PROCESS_MODE_DISABLED
		position = Vector3(0,-10,0)
