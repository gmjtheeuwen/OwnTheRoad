extends Node3D

signal phone_area_entered
signal phone_area_exited

func on_mouse_enter():
	phone_area_entered.emit()
	
func on_mouse_exit():
	phone_area_exited.emit()
