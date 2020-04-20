extends "res://scenes/Surgery.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	organ_inventory["Organ11"] = "BrokenHeart"
	sharp_sensitive_organs.append("BrokenHeart")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func interact_with_organ(organ_object, organ, tool_type, player):
	if organ_object == "Teeth" and tool_type == Tool.CHOCOLATE:
		player.current_tool = null
		if player.blue:
			$Common/BlueTool.set_texture(null)
		else:
			$Common/GreenTool.set_texture(null)
		organ_inventory["Organ11"] = "Heart"
		$OrganInventory/Heart.visible = $OrganInventory/BrokenHeart.visible
		$OrganInventory/BrokenHeart.visible = false
		task_completed = true
		
