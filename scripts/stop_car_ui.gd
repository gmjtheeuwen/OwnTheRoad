extends Control

@onready var stopButton 

signal stop_ui_pressed

func _on_stop_button_pressed() -> void:
	emit_signal("stop_ui_pressed") 
