extends State
class_name Driving_Phone

func enter():
	pass
	
func exit():
	pass
	
func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
	
func on_phone_exited():
	transitioned.emit(self, "driving")
