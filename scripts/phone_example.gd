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
