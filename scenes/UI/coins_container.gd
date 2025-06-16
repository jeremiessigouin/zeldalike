extends MarginContainer

@onready var coins_text = $CoinBox/Label


func update_coins():
	coins_text.text = str(Global.coins)
