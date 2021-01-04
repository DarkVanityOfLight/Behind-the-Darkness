extends Button

signal action
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called when the button is pressed
func _on_Control_pressed():
	# Get the action according to this button from its meta
	var choosen:int = get_meta("action")
	# Get the changing amount for the sanity from @MainController through 
	# performing the action
	var san = MainController.perform_action(choosen)
	# Change the sanity
	MainController.change_sanity(san)
	# Disable the button so no button can be pressed twice
	self.disabled = true
