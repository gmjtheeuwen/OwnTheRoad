extends Node2D
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("credits")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "credits":
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://scenes/title/title_screen.tscn")
