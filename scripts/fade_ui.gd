extends CanvasLayer

@onready var fade_rect = $ColorRect

signal fade_out_completed

func _ready() -> void:
	fade_rect.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 0.5)

func _on_stop_fade_out_complete():
	fade_out_completed.emit()

func _on_uber_app_open_uber_app() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1) 
	tween.finished.connect(_on_stop_fade_out_complete)
