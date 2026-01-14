extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	print("timer 1 started.")
	animation_player.play("intro cutscene")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
