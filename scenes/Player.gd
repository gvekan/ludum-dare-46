extends KinematicBody2D

export var speed = 200

var last_horizontal_input = ""
var last_vertical_input = ""


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		last_horizontal_input = "ui_left"
	elif Input.is_action_just_pressed("ui_right"):
		last_horizontal_input = "ui_right"
	elif not Input.is_action_pressed(last_horizontal_input):
		if Input.is_action_pressed("ui_left"):
			last_horizontal_input = "ui_left"
		elif Input.is_action_pressed("ui_right"):
			last_horizontal_input = "ui_right"
		else:
			last_horizontal_input = ""
	
	var x = 0
	if last_horizontal_input == "ui_left":
		x = -1
	elif last_horizontal_input == "ui_right":
		x = 1
		
	if Input.is_action_just_pressed("ui_up"):
		last_vertical_input = "ui_up"
	elif Input.is_action_just_pressed("ui_down"):
		last_vertical_input = "ui_down"
	elif not Input.is_action_pressed(last_vertical_input):
		if Input.is_action_pressed("ui_up"):
			last_vertical_input = "ui_up"
		elif Input.is_action_pressed("ui_down"):
			last_vertical_input = "ui_down"
		else:
			last_vertical_input = ""
			
	var y = 0	
	if last_vertical_input == "ui_up":
		y = -1
	elif last_vertical_input == "ui_down":
		y = 1
	
	var velocity = Vector2(x, y).normalized() * speed
	move_and_slide(velocity)
