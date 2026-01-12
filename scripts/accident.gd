extends Node3D

@export var car_scene : PackedScene
@onready var collision_point = $CollisionPoint
@onready var spawn_point = $CollisionPoint/SpawnPoint

var car: Car

func _ready() -> void:
	if car_scene == null: print("No path for car provided")
	car = car_scene.instantiate()

func on_trigger(body: Node3D):
	if (!body.is_in_group('player')): return
	if (!body is Vehicle) : return
	var player_car = body as Vehicle
	var speed = abs(player_car.local_velocity.z)
	var direction = -spawn_point.position.normalized()
	spawn_car(speed, direction, spawn_point.global_position)

func spawn_car(speed: float, direction: Vector3, location: Vector3):
	add_child(car)
	car.global_position = location
	car.speed = speed
	car.direction = direction
	car.rotation = spawn_point.rotation
