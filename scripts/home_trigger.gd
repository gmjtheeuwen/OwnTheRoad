extends Area3D

func _on_area_entered(body: Node3D):
	if body.is_in_group("player"):
		get_tree().call_deferred("change_scene_to_file", "res://scenes/cutscenes/credits.tscn")	
