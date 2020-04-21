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
	organ_inventory["Organ14"] = "Choco"
	rng.randomize()
	infect_organ()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func infect_organ():
	var organ_name = organ_corona.keys()[rng.randi_range(0,organ_corona.size()-1)]
	var og = $OrganInventory.get_node(organ_inventory[organ_name])
	var corona_key = organ_corona[organ_name]
	var corona = $OrganInventory.get_node(corona_key)
	organ_inventory[organ_name] = corona_key
	corona.visible = og.visible
	og.visible = false
	
func interact_with_organ(organ_object, organ, tool_type, player):
	if tool_type == Tool.AXE and organ_object in organ_corona.values():
		var broken = $OrganInventory.get_node(organ_object)
		var fixed_key = OG_organ_inventory[organ.name]
		var fixed = $OrganInventory.get_node(fixed_key)
		organ_inventory[organ.name] = fixed_key
		fixed.visible = broken.visible
		broken.visible = false
		count_treated_corona += 1
		if count_treated_corona == 4:
			task_completed = true
			print("Done")
		else:
			print("Infect")
			infect_organ()
	else:
		.interact_with_organ(organ_object, organ, tool_type, player)

