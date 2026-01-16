extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var fade_rect = $ColorRect2

signal skipped_cutscene

func _ready() -> void:
	animation_player.play("intro cutscene")
	

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		skipped_cutscene.emit()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	get_tree().call_deferred("change_scene_to_file","res://scenes/level_realisation.tscn")


func fade_out_completed() -> void:
	get_tree().call_deferred("change_scene_to_file","res://scenes/level_realisation.tscn")
