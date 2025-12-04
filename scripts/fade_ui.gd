extends CanvasLayer

@onready var fade_rect = $ColorRect

signal fade_out_completed

func _ready() -> void:
	fade_rect.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 0.5)

func _on_stop_3d_button_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1) 
	tween.finished.connect(_on_stop_fade_out_complete)

func _on_stop_fade_out_complete():
	emit_signal("fade_out_completed") 
