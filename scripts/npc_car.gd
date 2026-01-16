extends CharacterBody3D

@onready var point_container = $PointContainer
@export var starting_point_index: int = 0
@export var max_speed = 30.0
@export var cornering_speed = 8.0
@export var acceleration = 10.0

var points = []
var current_point_index = 0
var next_point: Vector3
var direction: Vector3
var speed: float
var target_speed: float
var driving := false

func _ready() -> void:	
	for point in point_container.get_children():
		if point is Node3D:
			points.append(point.global_position)
	current_point_index = starting_point_index
	next_point = points[(current_point_index+1)%points.size()]
	
	direction = points[current_point_index].direction_to(next_point)
	
	target_speed = max_speed
	
	global_rotation = Vector3(0, -direction.signed_angle_to(Vector3.RIGHT, Vector3.UP), 0)

	
func _physics_process(delta: float) -> void:
	if not driving:	pass
	
	var distance = global_position.distance_to(next_point)
	
	if distance < sqrt(speed) * speed/2.5:
		target_speed = cornering_speed
	else:
		target_speed = max_speed
	
	speed = move_toward(speed, target_speed, acceleration*delta)
	
	direction = points[current_point_index].direction_to(next_point)
	global_rotation = Vector3(0, -direction.signed_angle_to(Vector3.RIGHT, Vector3.UP), 0)
	velocity = speed*direction
	
	move_and_slide()
	
	if distance < 1:
		current_point_index = (current_point_index+1)%points.size()
		next_point = points[(current_point_index+1)%points.size()]		
