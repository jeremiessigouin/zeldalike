extends Area3D

@export var coin_value := 1

func _on_body_entered(_body):
	Global.add_coins(coin_value)
	queue_free()
