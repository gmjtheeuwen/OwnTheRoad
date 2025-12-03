extends CharacterBody3D


const SPEED = 5.0
const SENSITIVITY = 0.01

@onready var head = $Head
@onready var camera = $Head/Camera3D

# Remove the mouse in the scene
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Handle rotation of camera, with max and min height
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement / deceleration
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0
	
	move_and_slide()
