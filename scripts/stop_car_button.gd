extends StaticBody3D
class_name StopButton

@onready var meshInstance3D: MeshInstance3D = $MeshInstance3D
@onready var subViewport: SubViewport = $SubViewport

func _ready() -> void:
	input_event.connect(_on_input_event)


func _on_input_event(camera: Camera3D, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	var mouse3D = meshInstance3D.global_transform.affine_inverse() * event_position
	var calculate2DPosition = Vector2(mouse3D.x, mouse3D.z)
	
	var planeSize = meshInstance3D.mesh.size
	calculate2DPosition += planeSize / 2 
	calculate2DPosition /= planeSize
	
	var mouse2D = calculate2DPosition * Vector2(subViewport.size)
	
	event.position = mouse2D
	
	subViewport.push_input(event)
	
