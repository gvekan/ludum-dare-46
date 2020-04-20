extends Node2D


const SURGERY1 = preload("res://scenes/surgeries/Surgery1.tscn")
const START = preload("res://scenes/Start.tscn")

var current_surgery = null
var start_scene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Temp code
	start_scene = START.instance()
	start_scene.get_node("StartButton").connect("pressed",self,"_on_Start_pressed")
	add_child(start_scene)
	
func set_current_surgery(surgery_instance):
	current_surgery = surgery_instance
	add_child(current_surgery)
	current_surgery.get_node("Common/Pause").connect("pressed", self, "_on_Pause_current_surgery")
	current_surgery.connect("game_over",self,"_on_game_over")

func _on_Pause_current_surgery():
	current_surgery.stop()
	$Pause.visible = true
	# Display pause scene

func _on_Start_pressed():
	remove_child(start_scene)
	set_current_surgery(SURGERY1.instance())

func _on_Exit_pressed():
	$Pause.visible = false
	$GameOver.visible = false
	remove_child(current_surgery)
	start_scene = START.instance()
	start_scene.get_node("StartButton").connect("pressed",self,"_on_Start_pressed")
	add_child(start_scene)

func _on_Restart_pressed():
	$Pause.visible = false
	$GameOver.visible = false
	remove_child(current_surgery)
	set_current_surgery(SURGERY1.instance())
	
func _on_Continue_pressed():
	$Pause.visible = false
	current_surgery.start()
	
func _on_game_over():
	$GameOver.visible = true
