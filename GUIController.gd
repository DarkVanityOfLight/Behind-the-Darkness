extends Node

var title_screen = preload("res://Scenes/Titlescreen/Node2D.tscn")
var first_lvl = preload("res://Scenes/Lvl1/Lvl1.tscn")
var second_lvl = preload("res://Scenes/Lvl2/Lvl2.tscn")
var third_lvl = preload("res://Scenes/Lvl3/Lvl3.tscn")
var fourth_lvl = preload("res://Scenes/Lvl4/Lvl4.tscn")
var sanity_gui_scene = preload("res://Scenes/SanityGUI/Sanity.tscn")
onready var current_scene = title_screen.instance()
var sanity_gui = sanity_gui_scene.instance()
var san_holder = CanvasLayer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(current_scene)
	current_scene.get_node("gaian/Button").connect("pressed", self, "_start_game")
	MainController.connect("new_situation", self, "_on_MainController_scene_changed")

func _on_MainController_scene_changed():
	var current_situation = MainController.current_situation
	remove_child(current_scene)
	if current_situation >= 3 and current_situation <= 6:
		current_scene = second_lvl.instance()
	elif current_situation >= 7 and current_scene <= 9:
		current_scene = third_lvl.instance()
	elif current_scene >= 10 and current_scene <= 27:
		current_scene = fourth_lvl.instance()
		
	add_child(current_scene)
	
func _start_game():
	remove_child(current_scene)
	current_scene = first_lvl.instance()
	add_child(current_scene)
	san_holder.add_child(sanity_gui)
	add_child(san_holder)
