extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.value = 100

func _on_TextureProgress_value_changed(value):
	if value < 99:
		$End.hide()
	if value == 0:
		$End.hide()
