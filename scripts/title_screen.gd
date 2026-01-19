extends Node2D

@onready var fade_rect = $FadeUI/FadeRect
@onready var menu_action_sfx = $SFX
@export var bgm: AudioStreamPlayer

var play_tween 
var exit_tween 
var music_tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade_rect.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 0.0, 1.5)
	music_tween = create_tween()
	music_tween.tween_property(bgm,"volume_db",0,2.0)

func _on_play_button_pressed() -> void:
	menu_action_sfx.stream = load("res://assets/sounds/playbutton.wav")
	menu_action_sfx.volume_db = -9.0
	menu_action_sfx.play()
	
	music_tween = create_tween()
	music_tween.tween_property(bgm,"volume_db",-40,1.5)
	
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0) 
	tween.finished.connect(_on_play_fade_out_complete)

func _on_play_fade_out_complete():
	get_tree().call_deferred("change_scene_to_file","res://scenes/cutscenes/intro_cutscene.tscn")

func _on_exit_button_pressed() -> void:
	menu_action_sfx.stream = load("res://assets/sounds/clickbutton.wav")
	menu_action_sfx.volume_db = -9.0
	menu_action_sfx.play()
	
	music_tween = create_tween()
	music_tween.tween_property(bgm,"volume_db",-40,1.5)
	
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 1.0) 
	tween.finished.connect(_on_exit_fade_out_complete)

func _on_exit_fade_out_complete():
	get_tree().quit()
