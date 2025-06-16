extends Node3D

@onready var level_root = $LevelRoot

var current_area: Node = null

func _ready():
	load_area()
	DialogueManager.set_dialogue_ui($HUD/DialogueUI)

func load_area(scene_path = "res://scenes/Areas/Overworld_Area1.tscn"):
	if current_area:
		current_area.queue_free()
	
	var new_scene = load(scene_path).instantiate()
	level_root.add_child(new_scene)
	current_area = new_scene
	
	var spawn = current_area.get_node("SpawnPoint")
	$Player.global_transform.origin = spawn.global_transform.origin
