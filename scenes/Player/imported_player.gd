extends CharacterBody3D

@onready var animation = $Graphics/Player/AnimationPlayer

@export var speed: float = 7.0

func _ready():
	pass
	#position.y = 1

func SetStateIdle():
	animation.play("PlayerIdle")
	
func SetStateAttack():
	animation.play("Attack")


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

		velocity.x = input_dir.x * speed
		velocity.z = input_dir.z * speed

		move_and_slide()
		
	# Attacks
		if Input.is_action_pressed("attack"):
			SetStateAttack()
