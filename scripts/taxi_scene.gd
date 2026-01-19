extends Node2D

@onready var textbox = $CanvasLayer/MarginContainer/Textbox
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	animation_player.play("moving bg")
	textbox.text_finished.connect(_on_text_finished)
	textbox.all_text_finished.connect(_on_all_text_finished)

func _on_all_text_finished() -> void:
	animation_player.play("fade_out")
	await get_tree().create_timer(3.0).timeout
	get_tree().call_deferred("change_scene_to_file", "res://scenes/cutscenes/credits.tscn")

func _on_text_finished(text_content: String) -> void:
	print("Text finished: ", text_content)
