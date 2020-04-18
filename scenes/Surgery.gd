extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Patient/Mouth.connect("organ_clicked",self,"_on_organ_clicked")
	$Patient/Hairline.connect("organ_clicked",self,"_on_organ_clicked")
	$Patient/Blatter.connect("organ_clicked",self,"_on_organ_clicked")
	
	$Tool.connect("tool_clicked", self, "_on_tool_clicked")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_organ_clicked(organ, player):
	print("hej")
	

func _on_tool_clicked(tools):
	print("tool clicked")
