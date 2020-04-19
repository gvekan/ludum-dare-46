extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var start_time = 0

signal done

# Called when the node enters the scene tree for the first time.
func _ready():
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
