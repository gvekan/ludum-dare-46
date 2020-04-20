extends Node2D


const SURGERY1 = preload("res://scenes/surgeries/Surgery1.tscn")

var current_surgery = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Temp code
	set_current_surgery(SURGERY1.instance())
	

func set_current_surgery(surgery_instance):
	current_surgery = surgery_instance
	add_child(current_surgery)
	current_surgery.get_node("Common/Pause").connect("pressed", self, "_on_Pause_current_surgery")

func _on_Pause_current_surgery():
	current_surgery.stop()
	$Pause.visible = true
	# Display pause scene


func _on_Restart_pressed():
	$Pause.visible = false
	remove_child(current_surgery)
	set_current_surgery(SURGERY1.instance())
	


func _on_Continue_pressed():
	$Pause.visible = false
	current_surgery.start()
