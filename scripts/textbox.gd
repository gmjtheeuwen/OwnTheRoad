extends CanvasLayer
@onready var textbox_container = $TextboxContainer
@onready var label = $TextboxContainer/MarginContainer/Text/Label
var current_tween: Tween
const CHARACTER_READ_RATE = 0.1

enum State{
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var text_queue = []

signal text_finished(text_content)

func _ready() -> void:
	print("Starting state: State.READY")
	hide_textbox()
	queue_text("My head... What the hell happened?") #change accident
	queue_text("...")
	queue_text("... No. There's no way.")
	queue_text("This isn't happening.") #change accident
	queue_text("Yeah... It's no big deal.")
	queue_text("I'm fine. We're all fine.")
	queue_text("It's gonna be a hell of a fine, but nothing more.") #change accident
	queue_text("I'm gonna... reach the driver.")
	queue_text("I'll ask if... They're okay.")
	queue_text("I'll... get... yelled at...")
	queue_text("I'll... pay up...")
	queue_text("And I'll be on my way.")
	queue_text("... Please be okay.") #change scene to title screen

signal all_text_finished

func _process(_delta: float) -> void:
	match current_state:
		State.READY:
			if !text_queue.is_empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				label.visible_ratio = 1.0
				if current_tween:
					current_tween.kill()
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				text_finished.emit(label.text)
				change_state(State.READY)
				hide_textbox()
				if text_queue.is_empty():
					all_text_finished.emit()
	
func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	label.text = ""
	textbox_container.hide()

func show_textbox():
	textbox_container.show()

func display_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.visible_ratio = 0.0
	change_state(State.READING)
	textbox_container.show()
	if current_tween:
		current_tween.kill()
	current_tween = create_tween()
	current_tween.set_trans(Tween.TRANS_LINEAR)
	current_tween.tween_property(label, "visible_ratio", 1.0, len(next_text) * CHARACTER_READ_RATE)
	await current_tween.finished
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
