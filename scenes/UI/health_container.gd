extends MarginContainer

@export var heart_full_texture: Texture2D
@export var heart_empty_texture: Texture2D

@onready var hearts_box : GridContainer = $HeartsBox


#var current_health = Global.current_health
var max_health = Global.max_health

func update_hearts(current_health: int) -> void:
	# Reuse or create heart icons dynamically, no need to destroy them each time
		while hearts_box.get_child_count() < max_health:
			var heart = TextureRect.new()
			hearts_box.add_child(heart)

		while hearts_box.get_child_count() > max_health:
			hearts_box.get_child(hearts_box.get_child_count() - 1).queue_free()

		for i in range(max_health):
			var heart = hearts_box.get_child(i) as TextureRect
			if i < current_health:
				heart.texture = heart_full_texture
			else:
				heart.texture = heart_empty_texture
