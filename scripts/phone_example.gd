extends Node3D

signal phone_area_entered
signal phone_area_exited

@onready var message_app_mesh = $PhoneCase/MessageApp/MeshInstance3D

@export var message_app_icon : Sprite3D 
var app_opened = false

func on_mouse_enter():
	print("Enter phone")
	phone_area_entered.emit()
	
func on_mouse_exit():
	print("Exit phone")
	phone_area_exited.emit()

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		#var mesh:BoxMesh = message_app_mesh.mesh
		if not app_opened:
			message_app_icon.texture = load("res://assets/sprites/MessageAppNotif.png")
			app_opened = true
		else:
			message_app_icon.texture = load("res://assets/sprites/MessageApp.png")
			app_opened = false
