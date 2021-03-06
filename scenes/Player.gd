extends KinematicBody2D

const DEFAULT_SPEED = 200
const MAX_SPEED = 1500
var speed = DEFAULT_SPEED

var last_horizontal_input = ""
var last_vertical_input = ""

var current_tool = null

var running = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var blue = true

var green_texture = preload("res://assets/player-green.png")

var inputs = {
	"left": "other_left",
	"right": "other_right",
	"up": "other_up",
	"down": "other_down"
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	if not blue:
		$Sprite.texture = green_texture
		inputs = {
			"left": "ui_left",
			"right": "ui_right",
			"up": "ui_up",
			"down": "ui_down"
			}


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not running:
		return
	if (Input.is_action_pressed(inputs["up"]) and last_vertical_input == inputs["up"]) or (Input.is_action_pressed(inputs["down"]) and last_vertical_input == inputs["down"]) or (Input.is_action_pressed(inputs["left"]) and last_horizontal_input == inputs["left"]) or (Input.is_action_pressed(inputs["right"]) and last_horizontal_input == inputs["right"]):
		var speed_adder = (delta + 0.12) * DEFAULT_SPEED
		if speed < MAX_SPEED:
			speed += speed_adder
	else:
		speed = DEFAULT_SPEED
		
	if Input.is_action_just_pressed(inputs["left"]):
		last_horizontal_input = inputs["left"]
	elif Input.is_action_just_pressed(inputs["right"]):
		last_horizontal_input = inputs["right"]
	elif not Input.is_action_pressed(last_horizontal_input):
		if Input.is_action_pressed(inputs["left"]):
			last_horizontal_input = inputs["left"]
		elif Input.is_action_pressed(inputs["right"]):
			last_horizontal_input = inputs["right"]
		else:
			last_horizontal_input = ""
	
	var x = 0
	if last_horizontal_input == inputs["left"]:
		x = -1
	elif last_horizontal_input == inputs["right"]:
		x = 1
		
	if Input.is_action_just_pressed(inputs["up"]):
		last_vertical_input = inputs["up"]
	elif Input.is_action_just_pressed(inputs["down"]):
		last_vertical_input = inputs["down"]
	elif not Input.is_action_pressed(last_vertical_input):
		if Input.is_action_pressed(inputs["up"]):
			last_vertical_input = inputs["up"]
		elif Input.is_action_pressed(inputs["down"]):
			last_vertical_input = inputs["down"]
		else:
			last_vertical_input = ""
			
	var y = 0
	if last_vertical_input == inputs["up"]:
		y = -1
	elif last_vertical_input == inputs["down"]:
		y = 1
	
	var velocity = Vector2(x, y).normalized() * speed
	move_and_slide(velocity)
	

