extends Node

var title_screen = preload("res://Scenes/Titlescreen/Node2D.tscn")
var first_lvl = preload("res://Scenes/Lvl1/Lvl1.tscn")
onready var current_scene = title_screen.instance()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(current_scene)
	current_scene.get_node("gaian/Button").connect("pressed", self, "_start_game")
	MainController.connect("new_situation", self, "_on_MainController_scene_changed")

func _on_MainController_scene_changed():
	print("Situation changed")

func _start_game():
	remove_child(current_scene)
	current_scene = first_lvl.instance()
	add_child(current_scene)
	
