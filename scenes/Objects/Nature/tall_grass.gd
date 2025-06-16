extends RigidBody3D

@export var destroy_delay:= 0.3

func slice():
	#ANIMATION
	$CollisionShape3D.disabled = true
	#Optional: Spawn particle or item HERE
	#await animation.finished
	queue_free()
