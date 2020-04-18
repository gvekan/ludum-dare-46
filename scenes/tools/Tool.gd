extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal tool_clicked(tools)
var on_tool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_accept") and on_tool:
		emit_signal("tool_clicked",self)


func _on_Tool_body_entered(body):
	on_tool = true


func _on_Tool_body_exited(body):
	on_tool = false
