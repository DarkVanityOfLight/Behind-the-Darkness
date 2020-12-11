extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	MainController.connect("new_situation", self, "_on_Button_pressed")

func _on_Button_pressed():
	print("Situation changed")
