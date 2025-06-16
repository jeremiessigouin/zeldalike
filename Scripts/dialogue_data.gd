extends Node

#This Script is only a Dictionary. It stores all the dialogues for the game.

var dialogues = {
	
	"NPC_Father" : [
		{"speaker": "NPC_Father", "text": "Son... I have a bad feeling about this storm."},
		{"speaker": "NPC_Father", "text": "I need you to grab something for me in the cave..."}
		
	]
}

func get_dialogue(npc_id: String) -> Array:
	return dialogues.get(npc_id, [])
