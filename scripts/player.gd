extends CharacterBody3D

const SENSITIVITY = 0.01
const ROTATION_LERP_SPEED := 6.0

@onready var head = $Head
@onready var camera = $Head/Camera
@onready var collision = $Collision
@onready var phone = $Phone
@onready var label = $Head/Camera/Label
@onready var double_vision = $MeshInstance3D
var active_camera: Camera3D

var timeLabelVisible := 5.0
var phone_camera_target: Transform3D

@export var phone_open_pos := Vector3(0.15, -0.2, -0.45)
@export var phone_open_rot := Vector3(deg_to_rad(-10), 0, deg_to_rad(5))

@export var phone_closed_pos := Vector3(0.3, -0.6, -0.2)
@export var phone_closed_rot := Vector3(deg_to_rad(-25), 0, deg_to_rad(10))

@export var phone_anim_time := 0.35

var phone_tween: Tween
var phone_original_parent: Node

signal phone_pressed

# Remove the mouse in the scene
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	phone_original_parent = phone.get_parent()
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
		phone_pressed.emit()

func open_phone():
	if not active_camera:
		push_warning("No active camera set!")
		return
	
	label.visible = false
	double_vision.visible = false
	phone.visible = true

	if phone_tween:
		phone_tween.kill()

	phone.reparent(active_camera)

	phone.position = phone_closed_pos
	phone.rotation = phone_closed_rot

	phone_tween = create_tween().set_parallel()

	phone_tween.tween_property(
		phone,
		"position",
		phone_open_pos,
		phone_anim_time
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	phone_tween.tween_property(
		phone,
		"rotation",
		phone_open_rot,
		phone_anim_time
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func close_phone():
	double_vision.visible = true

	if phone_tween:
		phone_tween.kill()

	phone_tween = create_tween().set_parallel()

	phone_tween.tween_property(
		phone,
		"position",
		phone_closed_pos,
		phone_anim_time * 0.75
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

	phone_tween.tween_property(
		phone,
		"rotation",
		phone_closed_rot,
		phone_anim_time * 0.75
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

	phone_tween.finished.connect(func():
		phone.visible = false
		phone.reparent(phone_original_parent)
	)

func set_active_camera(cam: Camera3D):
	active_camera = cam
	active_camera.set_current(true)

func _physics_process(_delta: float) -> void:	
	move_and_slide()
