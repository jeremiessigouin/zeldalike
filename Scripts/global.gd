extends Node


var coins: int = 0
var max_health := 5.0
var current_health := 5.0

signal coins_update
signal health_update

func add_coins(coin_value):
	coins += coin_value
	emit_signal("coins_update")

func add_health(health_value):
	current_health += health_value
	emit_signal("health_update", current_health)
	
func subtract_health(damage):
	current_health -=  damage
	emit_signal("health_update", current_health)
