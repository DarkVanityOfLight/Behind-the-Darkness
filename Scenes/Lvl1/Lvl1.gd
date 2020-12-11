extends Node2D

var light = preload("res://Scenes/Light2D.tscn")
var action_button = preload("res://Scenes/ActionButton.tscn")
onready var things_to_know = get_node("/root/MainController")
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var actions = things_to_know.get_actions_for_situation(things_to_know.current_situation)
	for action in actions:
		var label = things_to_know.actions[action]
		var button = action_button.instance()
		button.text = label
		button.connect("button_down", self, "_on_button_press")
		$CenterContainer/Container.add_child(button)
		var buttonLight = light.instance()
		buttonLight.scale = button.get_transform().get_scale()
		button.set_meta("action", action)
		button.add_child(buttonLight)
