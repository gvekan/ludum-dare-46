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
	$Ekg.play("default")
	var tmp = start_time
	$Second.frame = tmp % 10
	tmp /= 10
	$Second10.frame = min(tmp % 10, 5)
	tmp /= 10
	$Minute.frame = min(tmp, 9)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if $Second.frame == 0:
		if $Second10.frame == 0:
			if $Minute.frame == 0:
				emit_signal("done")
				$Ekg.stop()
				$Ekg.set_animation("default")
				$Ekg.set_frame(0)
				$Timer.stop()
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
