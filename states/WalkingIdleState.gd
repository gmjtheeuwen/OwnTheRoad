extends State
class_name WalkingIdle		

@export var player: CharacterBody3D

func physics_update(_delta: float):
	if player.velocity.length() > 0:
		transitioned.emit(self, "walking")
