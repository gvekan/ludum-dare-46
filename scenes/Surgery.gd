extends Node2D

signal game_over
signal completed

var tool_scene = load("res://scenes/tools/Tool.tscn")

var count_open_organs = 0

var running = true

var playback_pos = 0.0

const OG_organ_inventory = {
	"Organ4": "Brain",
	"Organ5": "Teeth",
	"Organ6": "Bone2",
	"Organ7": "Throat",
	"Organ8": "Bone1",
	"Organ9": "Bone3",
	"Organ10": "Lung1",
	"Organ11": "Heart",
	"Organ12": "Lung2",
	"Organ13": "Bone4",
	"Organ14": "Hand",
	"Organ15": "Bone5",
	"Organ16": "Bone6",
	"Organ17": "Bone7",
	"Organ18": "Bone8"
}

var organ_inventory = {
	"Organ4": "Brain",
	"Organ5": "Teeth",
	"Organ6": "Bone2",
	"Organ7": "Throat",
	"Organ8": "Bone1",
	"Organ9": "Bone3",
	"Organ10": "Lung1",
	"Organ11": "Heart",
	"Organ12": "Lung2",
	"Organ13": "Bone4",
	"Organ14": "Hand",
	"Organ15": "Bone5",
	"Organ16": "Bone6",
	"Organ17": "Bone7",
	"Organ18": "Bone8"
}

var task_completed = false

var sharp_sensitive_organs = ["Brain", "Throat", "Lung1", "Lung2", "Heart"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Common/Patient.connect("organ_clicked",self,"_on_Patient_organ_clicked")
	for node in $ToolInventory.get_children():
		node.connect("tool_clicked", self, "_on_tool_clicked")
	for node in $OrganInventory.get_children():
		node.visible = false
		
func _process(delta):
	if running and task_completed and count_open_organs == 0:
		emit_signal("completed")
		stop()


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
		$ToolInventory.add_child(dropped_tool)
		dropped_tool.connect("tool_clicked", self, "_on_tool_clicked")
	player.current_tool = clicked_tool.type
	if player.blue:
		$Common/BlueTool.set_texture(clicked_tool.get_node("Sprite").texture)
	else:
		$Common/GreenTool.set_texture(clicked_tool.get_node("Sprite").texture)
	$ToolInventory.remove_child(clicked_tool)

func organ_clicked(organ, player):
	if player.current_tool == Tool.KNIFE and not organ.is_open():
		open_organ(organ)
		if organ_inventory[organ.name] == "Hand":
			$Clock.set_time(10)
		count_open_organs += 1
		$Clock.set_wait_time(max(1 - 0.5 - 0.1*count_open_organs, 0.1))
	elif player.current_tool == Tool.BANDAGE and organ.is_open():
		close_organ(organ)
		count_open_organs -= 1
		if count_open_organs > 0:
			change_panic_clock()
		else:
			$Clock.set_wait_time(1)
	elif organ.is_open():
		interact_with_organ(organ_inventory[organ.name], organ, player.current_tool, player)
	
func interact_with_organ(organ_object, organ, tool_type, player):
	print(organ_object)
	if death_by_sharp_tool(organ_object, organ, tool_type):
		$Clock.game_over()
	elif tool_type in Tool.sharp_tools:
		$Clock.set_time_and_test_game_over($Clock.get_time() - 5)
	elif organ.is_open() and tool_type == Tool.DEFIBRILLATOR and (organ_object == "Heart" or organ_object == "BrokenHeart"):
		$Clock.set_time($Clock.get_time() + 10)
	

func death_by_sharp_tool(organ_object, organ, tool_type):
	return tool_type in Tool.sharp_tools and organ_object in sharp_sensitive_organs

	

func open_organ(organ):
	organ.open()
	$OrganInventory.get_node(organ_inventory[organ.name]).visible = true

func close_organ(organ):
	organ.close()
	$OrganInventory.get_node(organ_inventory[organ.name]).visible = false
	

func time_is_up():
	emit_signal("game_over")
	stop()
	

func stop():
	running = false
	$Clock.stop()
	$Common/YSort/BluePlayer.running = false
	$Common/YSort/GreenPlayer.running = false
	playback_pos = $Common/BackgroundMusic.get_playback_position()
	$Common/BackgroundMusic.stop()
	
func start():
	running = true
	$Clock.start()
	$Common/YSort/BluePlayer.running = true
	$Common/YSort/GreenPlayer.running = true
	$Common/BackgroundMusic.play(playback_pos)
	
	
