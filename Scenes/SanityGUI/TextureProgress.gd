extends TextureProgress


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.value = 100

func _on_TextureProgress_value_changed(value):
	if value < 999:
		$End.hide()
	if value == 0:
		$Start.hide()
	if value > 999:
		$End.show()
	if value > 0:
		$Start
