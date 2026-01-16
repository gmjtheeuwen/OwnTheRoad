extends RigidBody3D
class_name Car

var speed: float
var direction: Vector3

func _physics_process(delta: float) -> void:
	position += (speed*delta)*direction
