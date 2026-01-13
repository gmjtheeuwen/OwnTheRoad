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

# Signal to notify when specific text is finished displaying
signal text_finished(text_content)

func _ready() -> void:
	print("Starting state: State.READY")
	hide_textbox()
	queue_text("this is words and text.")
	queue_text("I really hope this works.")
	queue_text("this is more words and text.")
	queue_text("Is it working.")

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
				# Emit signal with the current text before hiding
				text_finished.emit(label.text)
				change_state(State.READY)
				hide_textbox()
	
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
