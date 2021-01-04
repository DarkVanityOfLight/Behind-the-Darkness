extends Container


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect to the sanity_changed signal of @MainController
	MainController.connect("sanity_changed", self, "_on_Sanity_changed")
	# Set the starting value
	set_sanity(MainController.sanity)
	
# Set the sanity of the bar(Wrapper function)
func _on_Sanity_changed():
	set_sanity(MainController.sanity)
# Change the actual progress bar value
func set_sanity(value: int):
	$TextureProgress.value = value
