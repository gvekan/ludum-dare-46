extends Node2D

signal game_over
var tool_scene = load("res://scenes/tools/Tool.tscn")

var count_open_organs = 0

var running = true

var playback_pos = 0.0

var organ_inventory = {
	"Organ4": "Brain"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	$Common/Patient.connect("organ_clicked",self,"_on_Patient_organ_clicked")
	for node in get_tree().get_nodes_in_group("tools"):
		node.connect("tool_clicked", self, "_on_tool_clicked")


func _on_tool_clicked(clicked_tool, player):
	if not running:
		return
	tool_clicked(clicked_tool, player)

func _on_Patient_organ_clicked(organ, player):
	if not running:
		return
	organ_clicked(organ, player)
	
func _on_Clock_done():
	time_is_up()
	
func change_panic_clock():
	$Clock.set_wait_time(max(1 - 0.5 - 0.1*count_open_organs, 0.1))
	
func tool_clicked(clicked_tool, player):
	if player.current_tool:
		var dropped_tool = tool_scene.instance()
		dropped_tool.type = player.current_tool
		dropped_tool.position = clicked_tool.position
		add_child(dropped_tool)
		dropped_tool.connect("tool_clicked", self, "_on_tool_clicked")
	player.current_tool = clicked_tool.type
	if player.blue:
		$Common/BlueTool.set_texture(clicked_tool.get_node("Sprite").texture)
	else:
		$Common/GreenTool.set_texture(clicked_tool.get_node("Sprite").texture)
	remove_child(clicked_tool)

func organ_clicked(organ, player):
	if player.current_tool == Tool.KNIFE and not organ.is_open():
		open_organ(organ)
		count_open_organs += 1
		$Clock.set_wait_time(max(1 - 0.5 - 0.1*count_open_organs, 0.1))
	elif player.current_tool == Tool.BANDAGE and organ.is_open():
		close_organ(organ)
		count_open_organs -= 1
		if count_open_organs > 0:
			change_panic_clock()
		else:
			$Clock.set_wait_time(1)
	else:
		interact_with_organ(organ_inventory[organ.name], organ, player.current_tool)
	
func interact_with_organ(organ_object, organ, tool_type):
	if organ_object == "Brain":
		print("Brain interacted with")
		
	
func open_organ(organ):
	organ.open()
	get_node(organ_inventory[organ.name]).visible = true

func close_organ(organ):
	organ.close()
	get_node(organ_inventory[organ.name]).visible = false
	

func time_is_up():
	emit_signal("game_over")
	stop()
	

func stop():
	running = false
	$Clock.stop()
	$Common/YSort/BluePlayer.running = false
	$Common/YSort/GreenPlayer.running = false
	playback_pos = $Common/AudioStreamPlayer.get_playback_position()
	$Common/AudioStreamPlayer.stop()
	
func start():
	running = true
	$Clock.start()
	$Common/YSort/BluePlayer.running = true
	$Common/YSort/GreenPlayer.running = true
	$Common/AudioStreamPlayer.play(playback_pos)
	
	
