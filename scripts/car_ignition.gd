extends Node3D

signal button_pressed

@onready var highlight = $Highlight


func on_mouse_entered():
	highlight.show()
	
func on_mouse_exited():
	highlight.hide()


func _on_collision_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_event = event as InputEventMouseButton
		if mouse_event.button_index == MouseButton.MOUSE_BUTTON_LEFT and mouse_event.pressed:
			button_pressed.emit()
