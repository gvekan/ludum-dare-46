extends Node2D


const surgeries = [preload("res://scenes/surgeries/Surgery1.tscn"),preload("res://scenes/surgeries/Surgery2.tscn"),preload("res://scenes/surgeries/Surgery3.tscn")]
const START = preload("res://scenes/Start.tscn")

var current_surgery = null
var start_scene = null
var current_surgery_level = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	# Temp code
	start_scene = START.instance()
	start_scene.get_node("StartButton").connect("pressed",self,"_on_Start_pressed")
	add_child(start_scene)
	
func set_current_surgery(surgery):
	current_surgery = surgery.instance()
	add_child(current_surgery)
	current_surgery.get_node("Common/Pause").connect("pressed", self, "_on_Pause_current_surgery")
	current_surgery.connect("game_over",self,"_on_game_over")
	current_surgery.connect("completed",self,"_on_Surgery_completed")

func _on_Pause_current_surgery():
	current_surgery.stop()
	$Pause.visible = true
	# Display pause scene

func _on_Start_pressed():
	remove_child(start_scene)
	current_surgery_level = 1
	set_current_surgery(surgeries[current_surgery_level-1])

func _on_Exit_pressed():
	$Finished.visible = false
	$Pause.visible = false
	$GameOver.visible = false
	remove_child(current_surgery)
	start_scene = START.instance()
	start_scene.get_node("StartButton").connect("pressed",self,"_on_Start_pressed")
	add_child(start_scene)

func _on_Restart_pressed():
	$Pause.visible = false
	$GameOver.visible = false
	current_surgery_level = 1
	remove_child(current_surgery)
	set_current_surgery(surgeries[current_surgery_level-1])
	
func _on_Continue_pressed():
	$Pause.visible = false
	current_surgery.start()
	
func _on_game_over():
	$GameOver.visible = true
	current_surgery_level = 1
	$GameOver/DeadSound.play(0)
	
func _on_Surgery_completed():
	$Completed.visible = true
	$Completed/RichTextLabel.set_text("Congrats! You completed surgery " + String(current_surgery_level))


func _on_Next_pressed():
	remove_child(current_surgery)
	$Completed.visible = false
	current_surgery_level += 1
	if current_surgery_level > surgeries.size():
		$Finished.visible = true
	else:
		set_current_surgery(surgeries[current_surgery_level-1])
