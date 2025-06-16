extends CharacterBody3D

@export var speed: float = 10.0
@export var rotation_speed: float = 8.0

#signal health_changed(new_health)

var last_move_dir:= Vector3.DOWN #Initial facing direction

func _ready():
	position.y = 1
	$SwordAttack/Sword.hide()



func _physics_process(delta):
	#Input and movement
		var input_dir = Vector3.ZERO
		if Input.is_action_pressed("move_up"):
			input_dir.z -= 1
		if Input.is_action_pressed("move_down"):
			input_dir.z += 1
		if Input.is_action_pressed("move_left"):
			input_dir.x -= 1
		if Input.is_action_pressed("move_right"):
			input_dir.x += 1

		input_dir = input_dir.normalized()
		
		if input_dir !=  Vector3.ZERO:
			last_move_dir = input_dir #Save the last movement direction

		velocity.x = input_dir.x * speed
		velocity.z = input_dir.z * speed

		move_and_slide()
		
	#Rotation
		_rotate_toward(last_move_dir, delta)
	
	#Attacks
		if Input.is_action_just_pressed('attack'):
			attack()
			

func _rotate_toward(direction:Vector3, delta: float) -> void:
	var target_angle = atan2(direction.x, direction.z)
	var current_angle = rotation.y
	var smooth_angle = lerp_angle(current_angle, target_angle, rotation_speed * delta)
	rotation.y = smooth_angle

func attack():
	$SwordAttack/Sword.show()
	$SwordAttack/AnimationPlayer.play("Sword_Attack")
	var targets = $SwordAttack/SwordArea.get_overlapping_bodies()
	for body in targets:
		if body.is_in_group("Enemy"):
			body.hit(1.0)
		if body.is_in_group("Smashable"):
			body.slice()
	await $SwordAttack/AnimationPlayer.animation_finished
	$SwordAttack/Sword.hide()


func take_damage(damage):
	#Global.current_health = Global.current_health - damage
	#emit_signal("health_changed", Global.current_health)
	Global.subtract_health(damage)
	if Global.current_health <= 0:
		die()
		

func die():
	queue_free()
