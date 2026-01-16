extends Node3D

@onready var collision_point = $CollisionPoint
@onready var spawn_point = $SpawnPoint
@onready var car = $NPCCar

func _ready() -> void:
	if car == null: print("No car provided")
	car.position += Vector3(0, -10, 0)

func on_trigger(body: Node3D):
	if (!body.is_in_group('player')): return
	if (!body is Vehicle) : return
	var player_car = body as Vehicle
	var speed = abs(player_car.local_velocity.z)
	spawn_car(speed, spawn_point.global_position)

func spawn_car(speed: float, location: Vector3):
	car.global_position = location
	car.speed = speed
	car.rotation = spawn_point.rotation
	car.driving = true
	
