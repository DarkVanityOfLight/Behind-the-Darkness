extends Node2D

var light = preload("res://Scenes/Light2D.tscn")
var action_button = preload("res://Scenes/ActionButton.tscn")
onready var things_to_know = get_node("/root/MainController")
# Called when the node enters the scene tree for the first time.
func _ready():
	# Get all possible actions
	var actions = things_to_know.get_actions_for_situation(things_to_know.current_situation)
	# Create a button for each action
	for action in actions:
		var label = things_to_know.actions[action]
		var button = action_button.instance()
		button.text = label
		# Connect the buttons press signal to its own function
		button.connect("button_down", self, "_on_button_press")
		# Add the button
		$CenterContainer/Container.add_child(button)
		# Create the light
		var buttonLight = light.instance()
		# Scale the light to the button size
		buttonLight.scale = button.get_transform().get_scale()
		# Hold the action that the button performs in its meta
		button.set_meta("action", action)
		button.add_child(buttonLight)
