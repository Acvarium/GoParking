extends KinematicBody
var isPressed = false
var main
var offset = Vector3()
var mask = Vector3()

func _ready():
	set_physics_process(false)
	main = get_node("/root/main")
	mask = Vector3(1,0,0).rotated(Vector3(0,1,0), rotation.y).abs()
	
func _physics_process(delta):
	if isPressed:
		var slideVec = ((main.cursor_3d + offset) - translation) * mask
		move_and_collide(slideVec)

func _on_car_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			isPressed = true
			set_physics_process(true)
			offset = translation - main.cursor_3d
		else:
			isPressed = false
			set_physics_process(false)

func _on_Area_body_entered(body):
	if body != self:
		isPressed = false
		set_physics_process(false)
		print("AAAAAAAA!!!")
