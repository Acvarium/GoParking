extends KinematicBody
var isPressed = false
var main_node
var offset = Vector3()
var mask = Vector3()

func _ready():
	set_physics_process(false)
	main_node = get_node("/root/main")
	mask = Vector3(1,0,0).rotated(Vector3(0,1,0), rotation.y).abs()
	
func _physics_process(delta):
	if isPressed:
		var slideVec = ((main_node.cursor_3d + offset) - translation) * mask * 0.1
		move_and_collide(slideVec)

func _on_car_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			isPressed = true
			set_physics_process(true)
			offset = translation - main_node.cursor_3d
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		else:
			isPressed = false
			set_physics_process(false)
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Area_body_entered(body):
	if body != self:
		isPressed = false
		set_physics_process(false)
		main_node.crashed()
		print("AAAAAAAA!!!")
