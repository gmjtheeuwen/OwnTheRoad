extends CanvasLayer

@onready var fade_rect = $ColorRect

signal fade_out_completed

func _ready() -> void:
	fade_rect.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 0.5)

func _on_open_uber_app() -> void:
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1) 
	tween.finished.connect(fade_out_completed.emit)
