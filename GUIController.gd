extends Node

# Preload all needed Scenes
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
	# Add the current scene(title screen)
	add_child(current_scene)
	# Connect the start button to the _start_game function
	current_scene.get_node("gaian/Button").connect("pressed", self, "_start_game")
	
	# Connect to @MainController signals
	MainController.connect("new_situation", self, "_on_MainController_scene_changed")
	MainController.connect("end_game", self, "_on_MainController_end_game")

# Check if we need to display a new level on situation change
func _on_MainController_scene_changed():
	var current_situation = MainController.current_situation
	remove_child(current_scene)
	if current_situation >= 4 and current_situation <= 7:
		current_scene = second_lvl.instance()
	elif current_situation >= 8 and current_situation <= 9:
		current_scene = third_lvl.instance()
	elif current_situation >= 10 and current_situation <= 27:
		current_scene = fourth_lvl.instance()
		# Hide light cuz of some weird stuff happening
		san_holder.get_node("SanityControll").get_node("Light2D").enabled = false
	
	add_child(current_scene)
	
# Remove all children and display the end screen
func _on_MainController_end_game():
	var end_san = MainController.sanity
	for n in get_children():
		remove_child(n)
		n.queue_free()

# Start the game
func _start_game():
	# Remove the title screen
	remove_child(current_scene)
	# Add the first lvl
	current_scene = first_lvl.instance()
	add_child(current_scene)
	# Add the sanity gui
	san_holder.add_child(sanity_gui)
	add_child(san_holder)
