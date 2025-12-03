extends Control

@onready var stopButton 

signal stop_button_pressed

func _ready() -> void:
	#stopButton.pressed.connect(_on_stop_button_pressed)
	pass

func _on_stop_button_pressed() -> void:
	#emit_signal("stop_button_pressed") 
	GameEvents.stop_button_pressed.emit()
	print("Stop button pressed")
	pass # Replace with function body.
