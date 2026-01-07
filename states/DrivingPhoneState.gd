extends State
class_name Driving_Phone

func enter():
	pass
	
func exit():
	pass
	
func update(_delta: float, drunk_level: int = 0):
	pass

func physics_update(_delta: float, drunk_level: int = 0):
	pass
	
func on_phone_exited():
	print("phone exited")
	transitioned.emit(self, "driving")
