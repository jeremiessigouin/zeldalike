extends CharacterBody3D

@export var speed : float = 5.0
@export var hp: float = 3.0
@export var damage: float = 1.0
@export var knockback_resistance: float = 0.5
@export var knockback_duration: float = 0.5

var HeartPickupScene = preload("res://scenes/Objects/Consumables/heart_pickup.tscn")

var knockback_velocity: Vector3 = Vector3.ZERO
var knockback_timer: float = 0.0

var player: Node3D = null
var chasing: bool = false

func _ready():
	position.y = 1

func _physics_process(delta):
	#Knockback
	if knockback_timer > 0:
		velocity = knockback_velocity
		knockback_velocity = knockback_velocity.lerp(Vector3.ZERO, delta * 10)
		knockback_timer -= delta
		move_and_slide()
		return
	
	# Enemy chases the player. Otherwise, it stays in place.
	if chasing and player: 
		var direction = (player.global_transform.origin - global_transform.origin).normalized()
		velocity = direction * speed
		move_and_slide()
	else:
		velocity = Vector3.ZERO

func _on_vision_body_entered(body):
	if body.is_in_group('Player'):
		player = body
		chasing = true

func _on_vision_body_exited(body):
	if body == player:
		chasing = false
		player = null

func hit(damage_from_player):
	hp = hp - damage_from_player
	
	var force = calculate_knockback_force(damage_from_player)
	apply_knockback(player.global_transform.origin,force)
	if hp <= 0:
		die()

func calculate_knockback_force(damage_from_player):
	return clamp(damage_from_player * 1, 3.0, 10.0)

func apply_knockback(from_position, force):
	var direction = (global_transform.origin - from_position).normalized()
	knockback_velocity = direction * force / knockback_resistance
	knockback_timer = knockback_duration

func _on_damage_area_body_entered(body):
	if body.is_in_group("Player"):
		body.take_damage(damage)

func die():
	if randi_range(1, 2 == 1):
		var heart = HeartPickupScene.instantiate()
		get_tree().current_scene.add_child(heart)
		heart.global_transform.origin = global_transform.origin
		
	queue_free()
