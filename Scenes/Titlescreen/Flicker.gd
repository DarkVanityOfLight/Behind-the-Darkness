extends Light2D

# Create a noise texture wich will be used to set the alpha later
onready var noise = OpenSimplexNoise.new()
var value = 0.0
const MAX_VALUE = 10000000000

export var period = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	noise.period = 50
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	value += 0.5
	if (value > MAX_VALUE):# When the value gets too big it looses percision
		value = 0.0# And stops generating
	# Get the new alpha value from the noise texture
	var alpha =  ((noise.get_noise_1d(value) + 1)/4)
	self.color = Color(color.r, color.g, color.b, alpha)
