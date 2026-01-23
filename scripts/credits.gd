extends Node2D
@onready var animation_player = $AnimationPlayer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	animation_player.play("credits")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "credits":
		await get_tree().create_timer(3.0).timeout
		get_tree().change_scene_to_file("res://scenes/title/title_screen.tscn")
