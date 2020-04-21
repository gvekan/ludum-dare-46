extends "res://scenes/Surgery.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const broken_bones = {
	"Organ6": "Bone20",
	"Organ8": "Bone10",
	"Organ9": "Bone30",
	"Organ13": "Bone40",
	"Organ15": "Bone50",
	"Organ16": "Bone60",
	"Organ17": "Bone70",
	"Organ18": "Bone80"
}

var organ_list = ["Organ6", "Organ8", "Organ9", "Organ13","Organ15", 
	"Organ16", "Organ17", "Organ18"]

var count_broken_bones = 1

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	for i in range(count_broken_bones):
		var pos = rng.randi_range(0, organ_list.size())
		var rand_key = organ_list[pos]
		organ_list.remove(pos)
		organ_inventory[rand_key] = broken_bones[rand_key]


func interact_with_organ(organ_object, organ, tool_type, player):
	if tool_type == Tool.SCREWDRIVER and organ_object in broken_bones.values():
		count_broken_bones -= 1
		var broken = $OrganInventory.get_node(organ_object)
		var fixed_key = organ_object.substr(0, 5)
		var fixed = $OrganInventory.get_node(fixed_key)
		organ_inventory[organ.name] = fixed_key
		fixed.visible = broken.visible
		broken.visible = false
		if count_broken_bones == 0:
			task_completed = true
	elif tool_type in Tool.sharp_tools and not organ_object in broken_bones.values() and organ_object.find("Bone") != -1:
		count_broken_bones += 1
		var fixed = $OrganInventory.get_node(organ_object)
		var broken_key = organ_object + "0"
		var broken = $OrganInventory.get_node(broken_key)
		organ_inventory[organ.name] = fixed
		broken.visible = fixed.visible
		fixed.visible = false
		task_completed = false
	else:
		.interact_with_organ(organ_object, organ, tool_type, player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
