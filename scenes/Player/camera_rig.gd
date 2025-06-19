extends Node3D

@export var player: Node3D 
@export var height := 6.5
@export var distance := 0.0
@export var smooth_speed := 5.0

func _physics_process(delta):
	if not player:
		return
	
	# Set camera rig directly above the player
	var target_position = player.global_transform.origin + Vector3(0, height, distance)
	global_transform.origin = global_transform.origin.lerp(target_position, smooth_speed * delta)
