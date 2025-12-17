extends Area3D

@export var app_icon : Sprite3D 
var app_opened = false


func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	
	if not app_opened:
		app_icon.texture = load("res://assets/sprites/MessageAppNotif.png")
		app_opened = true
	else:
		app_icon.texture = load("res://assets/sprites/MessageApp.png")
		app_opened = false
	
	
	
