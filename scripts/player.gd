extends CharacterBody3D

const SENSITIVITY = 0.01

@onready var camera = $Head/Camera
@onready var collision = $Collision

# Remove the mouse in the scene
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Handle rotation of camera, with max and min height
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _physics_process(delta: float) -> void:	
	move_and_slide()
