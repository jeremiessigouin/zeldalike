extends Node

#This DialogueManager is an autoload script that handles the dialogue.
#It is triggered by interacting with the NPC, and then grabs the lines in DialogueData.
#Then, it tells the DialogueUI what to show.

var dialogue_ui : Node = null
var current_lines = []
var current_index = 0
var dialogue_active:= false


func set_dialogue_ui(ui_node: Node):
	dialogue_ui = ui_node
	
func start_dialogue(npc_id: String):
	if dialogue_active:
		return
	current_lines = DialogueData.get_dialogue(npc_id)
	current_index = 0
	dialogue_active = true
	show_line()
	
func show_line():
	dialogue_ui.visible = true
	var line = current_lines[current_index]
	dialogue_ui.get_node("%DialogueText").text = line['text']
	dialogue_ui.get_node("%SpeakerLabel").text = line['speaker']
	
func next_line():
	current_index += 1
	if current_index < current_lines.size():
		show_line()
	else:
		end_dialogue()

func end_dialogue():
	dialogue_ui.visible = false
	dialogue_active = false
