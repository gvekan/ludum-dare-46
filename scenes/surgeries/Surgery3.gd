extends "res://scenes/Surgery.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var organ_corona = {
	"Organ4": "corona4",
	"Organ5": "corona5",
	"Organ6": "corona6",
	"Organ7": "corona7",
	"Organ8": "corona8",
	"Organ9": "corona9",
	"Organ10": "corona10",
	"Organ11": "corona11",
	"Organ12": "corona12",
	"Organ13": "corona13",
	"Organ14": "corona14",
	"Organ15": "corona15",
	"Organ16": "corona16",
	"Organ17": "corona17",
	"Organ18": "corona18"
}

var count_treated_corona = 0

# Called when the node enters the scene tree for the first time.
func _ready():
#	rng.randomize()
#	infect_organ()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#func infect_organ():
#	var key = organ_corona.keys()[rng.randi_range(0,organ_corona.size())]
#	var other = $OrganInventory.get_node(organ_inventory[key])
#	var corona = $OrganInventory.get_node(organ_corona[key])
#	organ_corona[key] = 
#	$OrganInventory.get_node().visible = $OrganInventory/BrokenHeart.visible
#	$OrganInventory/BrokenHeart.visible = false

