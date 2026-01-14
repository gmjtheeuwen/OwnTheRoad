extends Node2D

@onready var textbox = $Textbox
@onready var animation_player = $AnimationPlayer

# References to all ColorRects and intro nodes
@onready var color_rects = {
	"ColorRect": $ColorRect,
	"ColorRect3": $ColorRect3,
	"ColorRect4": $ColorRect4,
	"ColorRect5": $ColorRect5
}

@onready var intros = {
	"intro_1": $intro_1,
	"intro_2": $intro_2,
	"intro_3": $intro_3,
	"intro_4": $intro_4
}

# Define triggers: text -> [color_rect_to_fade, intro_to_hide]
var text_triggers = {
	"this is more words and text.": {
		"fade_out": "ColorRect3",
		"hide_intro": "intro_1"
	}
}

func _ready() -> void:
	# Connect to textbox signal
	textbox.text_finished.connect(_on_text_finished)
	
	# Initial fade in
	animation_player.play("fade_in")
	await get_tree().create_timer(6).timeout

func _on_text_finished(text_content: String) -> void:
	print("Text finished: ", text_content)
	
	# Check if this text has a trigger
	if text_triggers.has(text_content):
		var trigger = text_triggers[text_content]
		
		# Fade out ColorRect
		if trigger["fade_out"] and color_rects.has(trigger["fade_out"]):
			fade_out_color_rect(color_rects[trigger["fade_out"]])
		
		# Hide intro
		if trigger["hide_intro"] and intros.has(trigger["hide_intro"]):
			intros[trigger["hide_intro"]].hide()

func fade_out_color_rect(color_rect: ColorRect) -> void:
	var tween = create_tween()
	tween.tween_property(color_rect, "modulate:a", 0.0, 1.0)
	await tween.finished
	color_rect.hide()
