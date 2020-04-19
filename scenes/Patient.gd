extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal organ_clicked(organ, player)


# Called when the node enters the scene tree for the first time.
func _ready():
	$Organ4.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ5.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ6.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ7.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ8.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ9.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ10.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ11.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ12.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ13.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ14.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ15.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ16.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ17.connect("organ_clicked",self,"_on_organ_clicked")
	$Organ18.connect("organ_clicked",self,"_on_organ_clicked")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_organ_clicked(organ, player):
	emit_signal("organ_clicked", organ, player)


