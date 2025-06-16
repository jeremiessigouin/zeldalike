extends Node3D



func _on_area_3d_body_entered(body):
	if body.is_in_group('Player') and Global.current_health < Global.max_health:
		Global.add_health(1.0)
		queue_free()
	elif body.is_in_group('Player') and Global.current_health >= Global.max_health:
		queue_free()
