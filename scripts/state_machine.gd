extends Node

@export var initial_state: State

var states: Dictionary = {}
var current_state: State

@export var max_drunk_level = 8
@export var drunk_level = 4

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta, drunk_level)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta, drunk_level)

func on_child_transition(state, new_state_name):
	print("State: %s" % new_state_name)
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
	
func increment_drunk_level():
	drunk_level += 1
	if (drunk_level > max_drunk_level): drunk_level = max_drunk_level
