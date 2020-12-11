extends Button

signal action
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Control_pressed():
	var choosen = self.get_meta("action")
	var new_situation:int = MainController.get_next_situation_from_action(choosen)
	MainController.change_current_situation(new_situation)
