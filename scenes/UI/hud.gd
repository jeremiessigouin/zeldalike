extends CanvasLayer

@onready var coins_container = $CoinsContainer
@onready var health_container = $HealthContainer
@onready var player = $"../Player"

func _ready():
	Global.connect("coins_update", coins_container.update_coins)
	Global.connect("health_update", health_container.update_hearts)
