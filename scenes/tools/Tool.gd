extends Area2D
class_name Tool

const KNIFE = "knife"
const BANDAGE = "bandage"
const AXE = "axe"
const CHOCOLATE = "chocolate"

var type_assets = {
	KNIFE: preload("res://assets/scalpel.png"),
	BANDAGE: preload("res://assets/bandaid.png"),
	AXE: preload("res://assets/axe.png"),
	CHOCOLATE: preload("res://assets/chocolate.png")
	}
	
export var type = KNIFE

func set_type(new_type):
	var texture = type_assets[new_type]
	if texture:
		type = new_type
		$Sprite.texture = texture

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal tool_clicked(tools, player)
var player_over_tool = null

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("tools")
	set_type(type)

func _input(event):
	if event.is_action_pressed("ui_accept") and player_over_tool:
		emit_signal("tool_clicked",self, player_over_tool)


func _on_Tool_body_entered(body):
	player_over_tool = body


func _on_Tool_body_exited(body):
	player_over_tool = null
