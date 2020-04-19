extends Node2D


var tool_scene = load("res://scenes/tools/Tool.tscn")

#onready var BlueToolSprite = get_node("BlueTool")
#onready var GreenToolSprite = get_node("GreenTool")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var count_open_organs = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Patient.connect("organ_clicked",self,"_on_Patient_organ_clicked")
	
	$Knife.connect("tool_clicked", self, "_on_tool_clicked")
	$Bandage.connect("tool_clicked", self, "_on_tool_clicked")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_tool_clicked(clicked_tool, player):
	if player.current_tool:
		var dropped_tool = tool_scene.instance()
		dropped_tool.type = player.current_tool
		dropped_tool.position = clicked_tool.position
		add_child(dropped_tool)
		dropped_tool.connect("tool_clicked", self, "_on_tool_clicked")
	player.current_tool = clicked_tool.type
	if player.blue:
		$BlueTool.set_texture(clicked_tool.get_node("Sprite").texture)
	else:
		$GreenTool.set_texture(clicked_tool.get_node("Sprite").texture)
	remove_child(clicked_tool)


func _on_Patient_organ_clicked(organ, player):
	if player.current_tool == Tool.KNIFE:
		if organ.is_open():
			return
		organ.open()
		count_open_organs += 1
		$Clock.set_wait_time(max(1 - 0.5 - 0.1*count_open_organs, 0.1))
	elif player.current_tool == Tool.BANDAGE:
		if not organ.is_open():
			return
		organ.close()
		count_open_organs -= 1
		if count_open_organs > 0:
			change_panic_clock()
		else:
			$Clock.set_wait_time(1)

func change_panic_clock():
	$Clock.set_wait_time(max(1 - 0.5 - 0.1*count_open_organs, 0.1))


func _on_Clock_done():
	print("Game over")
