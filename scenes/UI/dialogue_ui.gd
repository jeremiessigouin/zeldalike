extends CanvasLayer

var dialogue_lines: Array = []
var current_index := 0
var on_dialogue_finished: Callable

func start_dialogue(lines:Array, speaker_name: String, finished_callback: Callable) -> void:
	dialogue_lines = lines
	current_index = 0
	on_dialogue_finished = finished_callback
	$Panel/VBoxContainer/SpeakerLabel.text = speaker_name
	visible = true
	show_line()
	
func show_line():
	if current_index < dialogue_lines.size():
		$Panel/VBoxContainer/DialogueText.text = dialogue_lines[current_index]
	else:
		end_dialogue()


func next_line():
	current_index += 1
	show_line()
	
func end_dialogue():
	visible = false
	if  on_dialogue_finished:
		on_dialogue_finished.call()

func _on_next_button_pressed():
	next_line()
	

func _unhandled_input(event):
	if visible and event.is_action_pressed("interact"):
		next_line()
