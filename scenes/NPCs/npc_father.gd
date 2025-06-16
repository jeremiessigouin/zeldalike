extends CharacterBody3D

@export var npc_id: String = "NPC_Father"
var current_line = 0
var player_in_range:= false


#SCRIPTED MOVEMENT TO COME


# DIALOGUE MANAGEMENT

func _on_interaction_body_entered(body):
	if body.is_in_group("Player"):
		player_in_range = true

func _on_interaction_body_exited(body):
	if body.is_in_group("Player"):
		player_in_range = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if DialogueManager.dialogue_active:
			DialogueManager.next_line()
		else:
			DialogueManager.start_dialogue(npc_id)
	elif not player_in_range and DialogueManager.dialogue_active:
		DialogueManager.end_dialogue()
