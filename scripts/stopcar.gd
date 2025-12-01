extends Node3D

@onready var stopButton 

signal stop_button_pressed


func _on_stop_button_pressed() -> void:
	emit_signal("stop_button_pressed") 
	print("Stop button pressed")
	pass # Replace with function body.
