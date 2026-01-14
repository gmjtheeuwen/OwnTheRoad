extends Node2D

@onready var textbox = $Textbox
@onready var animation_player = $AnimationPlayer

@onready var accident = {
	"accident_1": $CanvasLayer/MarginContainer/accident_1,
	"accident_2": $CanvasLayer/MarginContainer/accident_2,
	"accident_3": $CanvasLayer/MarginContainer/accident_3,
	"accident_4": $CanvasLayer/MarginContainer/accident_4,
}

var text_triggers = {
	"My head... What the hell happened?": {
		"hide_accident": "accident_1"
		},
	"This isn't happening.": {
		"hide_accident": "accident_2"
	},
	"It's gonna be a hell of a fine, but nothing more.": {
		"hide_accident": "accident_3"
		},
	"... Please be okay.": {
		"hide_accident": "accident_4"
		}
}

# In your Node2D script _ready() function
func _ready() -> void:
	# Connect to textbox signals
	textbox.text_finished.connect(_on_text_finished)
	textbox.all_text_finished.connect(_on_all_text_finished)
	# Initial fade in
	animation_player.play("shaky_cam")

func _on_all_text_finished() -> void:
	# Optional: wait a bit before transitioning
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")

	# Initial fade in
	animation_player.play("shaky_cam")
func _on_text_finished(text_content: String) -> void:
	print("Text finished: ", text_content)
	
	if text_triggers.has(text_content):
		var trigger = text_triggers[text_content]
		
		# Fade out ColorRect
		if trigger["hide_accident"] and accident.has(trigger["hide_accident"]):
			accident[trigger["hide_accident"]].hide()
 
