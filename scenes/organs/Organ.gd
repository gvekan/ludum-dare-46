
extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal organ_clicked(organ, player)
var player_over_organ = null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("ui_accept") and player_over_organ:
		emit_signal("organ_clicked",self, player_over_organ)


func _on_Organ_body_entered(body):
	player_over_organ = body


func _on_Organ_body_exited(body):
	player_over_organ = null
	
func is_open():
	return $Sprite.visible

func open():
	$Sprite.visible = true
	
func close():
	$Sprite.visible = false
