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
	current_surgery.get_node("Common/Pause/Button").connect("pressed", self, "pause_current_surgery")

func pause_current_surgery():
	current_surgery.pause()
	# Display pause scene
