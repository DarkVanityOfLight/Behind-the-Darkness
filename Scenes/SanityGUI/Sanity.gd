extends Container


# Called when the node enters the scene tree for the first time.
func _ready():
	MainController.connect("sanity_changed", self, "_on_Sanity_changed")
	set_sanity(MainController.sanity)

func _on_Sanity_changed():
	set_sanity(MainController.sanity)

func set_sanity(value: int):
	$TextureProgress.value = value
