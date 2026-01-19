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
	queue_text("Driver
	... You look rough, buddy. How much did you
	have to drink?")
	queue_text("You
	Not that much, just had a rough day. Felt like I could use a break.")
	queue_text("Driver
	Fair enough. We can all use some time off now and then.")
	queue_text("You
	Yeah.")
	queue_text("Driver
	Sometimes I wonder if I'll ever get a break! Haha.
	I almost envy how careless you young people are.")
	queue_text("Driver
	But I'm glad you're not THAT careless. Trying to drive
	in your condition would be a fool's errand.")
	queue_text("You
	I thought about it. But I figured this'd be easier.")
	queue_text("Driver
	I see. So, are you just going to crash on your couch when you
	get home? or do you have some other plans?")
	queue_text("You
	I gotta feed my dog.")
	queue_text("Driver
	You're thinking about that this late? You're definitely drunk! Haha!")
	queue_text("You
	I guess I am, I'm just gonna zone out now if it's chill with you.")
	queue_text("Driver
	I don't mind. Just don't fall asleep or puke on my seats.")
	

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
