extends CharacterBody3D

const SENSITIVITY = 0.01
const ROTATION_LERP_SPEED := 6.0

@onready var head = $Head
@onready var camera = $Head/Camera
@onready var collision = $Collision
@onready var phone = $Phone
@onready var label = $Head/Camera/Label

var timeLabelVisible := 5.0
var phone_camera_target: Transform3D

signal phone_opened
signal phone_closed

# Remove the mouse in the scene
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var event = InputMap.action_get_events("phone")[0] as InputEventKey
	label.text = "Press [%s] " % event.as_text_physical_keycode() + " to pull up your phone"

# Handle rotation of camera, with max and min height
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if !phone.visible:
			rotate_y(-event.relative.x * SENSITIVITY)
			camera.rotate_x(-event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))
		
func _process(delta: float) -> void:
	if timeLabelVisible > 0.0:
		timeLabelVisible -= delta
	else:
		label.visible = false
	if Input.is_action_just_pressed("phone"):
		if phone.visible:
			phone.visible = false
			phone_closed.emit()
		else:
			label.visible = false
			phone.visible = true
			phone_opened.emit()
		

func _physics_process(_delta: float) -> void:	
	move_and_slide()
