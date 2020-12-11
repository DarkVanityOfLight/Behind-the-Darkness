extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	MainController.connect("new_situation", self, "_on_MainController_scene_changed")

func _on_MainController_scene_changed():
	print("Situation changed")
