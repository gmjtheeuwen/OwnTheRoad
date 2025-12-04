extends Node3D

@export var car : PackedScene
@export var spawnDistance = 40.0
@export var spawnPositions : Array[int] = [-8,-4,0,4,8]
@export var poolSize = 50
@onready var carContainer = $Environment/CarContainer
var carPool: Array[Node3D] = []
var spawnIndex = 0
var playerCarStopped = false

func _ready() -> void:
	GameEvents.stop_button_pressed.connect(on_stop_pressed)
	
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
	

func on_stop_pressed() -> void:
	playerCarStopped = true
