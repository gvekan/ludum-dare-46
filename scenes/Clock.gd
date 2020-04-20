extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var start_time = 0

signal done

var default_digit_texture = preload("res://assets/digital-numbers.png")
var default_colon_texture = preload("res://assets/colon.png")
var panic_digit_texture = preload("res://assets/digital-numbers-red.png")
var panic_colon_texture = preload("res://assets/colon-red.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	start_clock_with(start_time)

func start_clock_with(time):
	if time < 1:
		game_over()
		return
	var tmp = time
	$Second.frame = tmp % 10
	tmp /= 10
	$Second10.frame = min(tmp % 10, 5)
	tmp /= 10
	$Minute.frame = min(tmp, 9)
	$Timer.start()
	$Ekg.play("default")

func game_over():
	$Timer.stop()
	$Ekg.stop()
	$Ekg.set_animation("default")
	$Ekg.set_frame(0)
	emit_signal("done")
	
func start():
	$Timer.start()
	$Ekg.play()
		

func stop():
	$Timer.stop()
	$Ekg.stop()
	


func _on_Timer_timeout():
	if $Second.frame == 0:
		if $Second10.frame == 0:
			if $Minute.frame == 0:
				game_over()
				return
			else:
				$Minute.frame -= 1
			$Second10.frame = 5
		else:
			$Second10.frame -= 1
		$Second.frame = 9
	else:
		$Second.frame -= 1

func set_wait_time(time):
	if $Timer.wait_time == time:
		return
	$Timer.wait_time = time
	if time < 1:
		$Ekg.play("panic")
		$Second.set_texture(panic_digit_texture)
		$Second10.set_texture(panic_digit_texture)
		$Minute.set_texture(panic_digit_texture)
		$Colon.set_texture(panic_colon_texture)
	else:
		$Ekg.play("default")
		$Second.set_texture(default_digit_texture)
		$Second10.set_texture(default_digit_texture)
		$Minute.set_texture(default_digit_texture)
		$Colon.set_texture(default_colon_texture)
