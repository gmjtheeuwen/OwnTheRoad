extends Node3D

@export var car : PackedScene
@export var spawnDistance = 80.0
@export var spawnPositions : Array[int] = [-8,-4,0,4,8]
@export var poolSize = 50
@onready var carContainer = $CarContainer
@onready var timer = $SpawnTimer
var carPool: Array[Node3D] = []
var spawnIndex = 0

func _ready() -> void:
	for i in range(0,poolSize):
		var carNode = car.instantiate()
		carNode.name = "Car_%s" % i
		carPool.append(carNode)
		carNode.process_mode = Node.PROCESS_MODE_DISABLED
		carNode.position = Vector3(0, -10, 0)
		carContainer.add_child(carNode)

func spawnCar() -> void:
	var carToSpawn = carPool[spawnIndex]
	spawnIndex = (spawnIndex + 1) % poolSize
	
	var lane = randi() % spawnPositions.size()
	var spawnX = spawnPositions[lane]
	var spawnY = -spawnDistance
	carToSpawn.position = Vector3(spawnX, 0, spawnY)
	carToSpawn.process_mode = Node.PROCESS_MODE_INHERIT


func _on_car_stopped() -> void:
	reset_game()

func reset_game() -> void:
	get_tree().reload_current_scene()
