extends Node
signal new_situation
signal sanity_changed

const actions = [
	# At the lake
	"Look at shadows",#0
	"Throw a stone at the shadow",#1
	"Keep walking",#2
	# At the forest
	"Search for map",#3
	"Walk around",#4
	"Follow the map",#5
	"Follow the weird noises",#6
	# On the hill
	"Take the amulet",#7
	# Kee walking
	# In the castle
	"Take orb",#8
	"Sit around"#9
	]
const situations = [
	# At the lake
	"At the lake (No action)",#0
	"At the lake (Looked at shadow)",#1
	"At the lake (Threw stone)",#2
	"At the lake (Threw stone and looked at show)",#3
	# At the forest
	"At the forest (No action)",#4
	"At the forest (Searched for map)",#5
	"At the forest (Walked around)",#6
	"At the forest (Walked around and searched for map)",#7
	# On the hill
	"On the hill (No action)",#8
	"On the hill (Took amulet)",#9
	# In the castle
	"In the castle (Sane and no action with amulete)",#10
	"In the castle (Insane and no action with amulete)",#11
	"In the castle (semi sane and no action with amulete)",#12
	"In the castle (Sane and no action without amulete)",#13
	"In the castle (Insane and no action without amulete)",#14
	"In the castle (semi sane and no action without amulete)",#15
	"In the castle (Sane and took orb without amulet)",#16
	"In the castle (Insane and took orb without amulet)",#17
	"In the castle (Semi sane and took orb without amulet)",#18
	"In the castle (Sane and took orb with amulet)",#19
	"In the castle (Insane and took orb with amulet)",#20
	"In the castle (Semi sane and took orb with amulet)",#21
	"In the castle (Sane and sat around with amulete)",#22
	"In the castle (Insane and sat around with amulete)",#23
	"In the castle (Semi sane and sat around without amulete)",#24
	"In the castle (Sane and sat around without amulete)",#25
	"In the castle (Insane and sat around without amulete)",#26
	"In the castle (Semi sane and sat around without amulete)",#27
]
	
const actions_in_situations = [
	# At the lake
	[0, 1, 2], # At the lake (No actions)
	[1, 2], # At the lake (Looked at shadow)
	[0, 2], # At the lake (Threw stone)
	[2], # At the lake (Threw stone and looked at shadow)
	# At the forest
	[3, 4, 6],# At the forest (No action)
	[4, 5, 6],# At the forest (Searched for map)
	[3, 6],# At the forest (Walked around)
	[5, 6],# At the forest (Walked around and searched for map)
	# On the hill
	[7, 4],# On the hill (No action)
	[4], # On the hill(Took amulete)
	# In the castle
	[8, 9],# In the castle (Sane and no action with amulet)
	[8, 9],# In the castle (Insane and no action with amulet)
	[8, 9], # In the castle (Semisane and no action with amulet)
	[8, 9],# In the castle (Sane and no action without amulet)
	[8, 9],# In the castle (Insane and no action without amulet)
	[8, 9], # In the castle (Semisane and no action without amulet)
	[],# In the castle (Sane and took orb without amulet)
	[],# In the castle (Insane and took orb without amulet)
	[],# In the castle (Semisane and took orb without amulet)
	[],# In the castle (Sane and took orb with amulet)
	[],# In the castle (Insane and took orb with amulet)
	[],# In the castle (Semisane and took orb with amulet)
	[8],# In the castle (Sane and sat around with amulete)
	[8],# In the castle (Insane and sat around with amulete)
	[8],# In the castle (Semisane and sat around with amulete)
	[8],# In the castle (Sane and sat around without amulete)
	[8],# In the castle (Insane and sat around without amulete)
	[8],# In the castle (Semisane and sat around without amulete)
]
const init_situation: int = 0
const end_situations = [13, 14, 15, 16, 17, 18]
var next_situations = [
	# At the lake
	[1, 2, 4, 0, 0, 0, 0, 0, 0], # At the lake (No actions)
	[0, 3, 4, 0, 0, 0, 0, 0, 0], # At the lake (Looked at shadow)
	[3, 0, 4, 0, 0, 0, 0, 0, 0], # At the lake (Threw stone)
	[0, 0, 4, 0, 0, 0, 0, 0, 0], # At the lake (Threw stone and looked at shadow)
	# At the forest
	[0, 0, 0, 5, 6, 0, 8, 0, 0],# At the forest (No action)
	[0, 0, 0, 7, 0, 8, 8, 0, 0],# At the forest (Searched for map)
	[0, 0, 0, 0, 7, 0, 8, 0, 0],# At the forest (Walked around)
	[0, 0, 0, 0, 0, 8, 8, 0, 0],# At the forest (Walked around and searched for map)
	# On the hill
	# TODO Set action according to sanity
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# On the hill (No action)
	[0, 0, 0, 0, 0, 0, 0, 0, 0], # On the hill(Took amulete)
	# In the castle
	[0, 0, 0, 0, 0, 0, 0, 19, 25],# In the castle (Sane and no action with amulet)
	[0, 0, 0, 0, 0, 0, 0, 20, 26],# In the castle (Insane and no action with amulet)
	[0, 0, 0, 0, 0, 0, 0, 21, 27],# In the castle (Semisane and no action with amulet)
	[0, 0, 0, 0, 0, 0, 0, 16, 22],# In the castle (Sane and no action without amulet)
	[0, 0, 0, 0, 0, 0, 0, 17, 23],# In the castle (Insane and no action without amulet)
	[0, 0, 0, 0, 0, 0, 0, 18, 24],# In the castle (Semisane and no action without amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Sane and took orb without amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Insane and took orb without amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Semisane and took orb without amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Sane and took orb with amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Insane and took orb with amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Semisane and took orb with amulet)
	[0, 0, 0, 0, 0, 0, 0, 18, 0],# In the castle (Sane and sat around with amulete)
	[0, 0, 0, 0, 0, 0, 0, 19, 0],# In the castle (Insane and sat around with amulete)
	[0, 0, 0, 0, 0, 0, 0, 20, 0],# In the castle (Semisane and sat around with amulete)
	[0, 0, 0, 0, 0, 0, 0, 16, 0],# In the castle (Sane and sat around without amulete)
	[0, 0, 0, 0, 0, 0, 0, 17, 0],# In the castle (Insane and sat around without amulete)
	[0, 0, 0, 0, 0, 0, 0, 18, 0],# In the castle (Semisane and sat around without amulete)
	]
	
const reward = [
	# At the lake
	[0, 0, 0, 0, 0, 0, 0, 0, 0], # At the lake (No actions)
	[0, 0, 0, 0, 0, 0, 0, 0, 0], # At the lake (Looked at shadow)
	[0, 0, 0, 0, 0, 0, 0, 0, 0], # At the lake (Threw stone)
	[0, 0, 0, 0, 0, 0, 0, 0, 0], # At the lake (Threw stone and looked at shadow)
	# At the forest
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# At the forest (No action)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# At the forest (Searched for map)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# At the forest (Walked around)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# At the forest (Walked around and searched for map)
	# On the hill
	# TODO Set action according to sanity
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# On the hill (No action)
	[0, 0, 0, 0, 0, 0, 0, 0, 0], # On the hill(Took amulete)
	# In the castle
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Sane and no action with amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Insane and no action with amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Semisane and no action with amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Sane and no action without amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Insane and no action without amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Semisane and no action without amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Sane and took orb without amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Insane and took orb without amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Semisane and took orb without amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Sane and took orb with amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Insane and took orb with amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Semisane and took orb with amulet)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Sane and sat around with amulete)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Insane and sat around with amulete)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Semisane and sat around with amulete)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Sane and sat around without amulete)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Insane and sat around without amulete)
	[0, 0, 0, 0, 0, 0, 0, 0, 0],# In the castle (Semisane and sat around without amulete)
	]

var sanity: int = 100

var current_situation = init_situation

func get_actions_for_situation(situation: int):
	return actions_in_situations[situation]

func get_next_situation_from_action_and_situation(current_situation, action):
	var next_situation = next_situations[current_situation][action]
	return next_situation
	
func get_next_situation_from_action(action:int) -> int:
	var next_situation = next_situations[current_situation][action]
	return next_situation

func change_sanity(amount: int):
	sanity += amount
	emit_signal("sanity_changed")

func perform_action(a):
	var san = reward[current_situation][a]
	current_situation = next_situations[current_situation][a]
	emit_signal("new_situation")
	return san
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
