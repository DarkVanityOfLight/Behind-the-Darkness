extends Button

signal action
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Control_pressed():
	var choosen:int = get_meta("action")
	var san = MainController.perform_action(choosen)
	MainController.change_sanity(san)
	self.disabled = true
