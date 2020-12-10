extends Light2D


# Declare member variables here. Example
var velocity = Vector2(100, 50)
var state = 0
const speed = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	global_position += velocity * speed * delta
	
	if (global_position.x >= 800):
		velocity.x -= 100
	elif (global_position.x <= 200):
		velocity.x += 100

	if (global_position.y >= 220):
		velocity.y -= 50
	elif (global_position.y <= 75):
		velocity.y += 50

func _on_Timer_timeout():
	state =  floor(rand_range(0, 3))
	if state == 0:
		pass
	elif state == 1:
		velocity.x = 100
	elif state == 2:
		velocity.x = -100
		
	state =  floor(rand_range(0, 3))
	if state == 0:
		pass
	elif state == 1:
		velocity.y = -100
	elif state == 2:
		velocity.y = 100
		

