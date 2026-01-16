extends Node2D

@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	animation_player.play("intro cutscene")

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().call_deferred("change_scene_to_file","res://scenes/level_realisation.tscn")
