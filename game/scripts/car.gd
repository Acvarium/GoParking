extends KinematicBody

var step = 1.0
export var mouseForward = false
export var mouseBackword = false
var s = 0

func _ready():
	pass

func _input(event):
	if Input.is_action_just_pressed("LMB"):
		$frontRay.force_raycast_update()
		$backRay.force_raycast_update()
		if mouseForward and !$frontRay.is_colliding():
			move(true)

		elif mouseBackword and !$backRay.is_colliding():
			move(false)


func move(forward):
	if forward:
		translate(Vector3(-step,0,0))
	else:
		translate(Vector3(step,0,0))
	mouseForward = false
	mouseBackword = false

func _on_front_mouse_entered():
	mouseForward = true
	$aB.visible = true

func _on_front_mouse_exited():
	mouseForward = false
	$aB.visible = false

func _on_back_mouse_entered():
	mouseBackword = true
	$aF.visible = true

func _on_back_mouse_exited():
	mouseBackword = false
	$aF.visible = false
