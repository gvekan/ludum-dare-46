extends Node2D


var tool_scene = load("res://scenes/tools/Tool.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Patient/Organ4.connect("organ_clicked",self,"_on_organ_clicked")
	
	$Knife.connect("tool_clicked", self, "_on_tool_clicked")
	$Apple.connect("tool_clicked", self, "_on_tool_clicked")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_organ_clicked(organ, player):
	if player.current_tool == Tool.KNIFE:
		organ.open()
	

func _on_tool_clicked(clicked_tool, player):
	if player.current_tool:
		var dropped_tool = tool_scene.instance()
		dropped_tool.type = player.current_tool
		dropped_tool.position = clicked_tool.position
		add_child(dropped_tool)
		dropped_tool.connect("tool_clicked", self, "_on_tool_clicked")
	player.current_tool = clicked_tool.type
	remove_child(clicked_tool)
